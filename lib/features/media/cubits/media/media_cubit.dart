import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:t_store_admin_panel/core/errors/error_model.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/text_strings.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/navigation.dart';
import 'package:t_store_admin_panel/core/utils/utils/popups/custom_dialogs.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/app_context.dart';
import 'package:t_store_admin_panel/core/utils/utils/popups/full_screen_loader.dart';
import 'package:t_store_admin_panel/core/utils/utils/popups/loaders.dart';
import 'package:t_store_admin_panel/data/models/image/image_model.dart';
import 'package:t_store_admin_panel/domain/repositories/media/media_repository.dart';
part 'media_state.dart';

class MediaCubit extends Cubit<MediaState> {
  MediaCubit(this.mediaRepository) : super(MediaInitial());

  // static MediaCubit get intance => GetIt.I<MediaCubit>(); // Like Get.find() in Getx

  // Media Repository
  final MediaRepository mediaRepository;

  // dropzone controller
  late DropzoneViewController dropzoneController;
  // selected category
  MediaCategory selectedPath = MediaCategory.folders;
  // selected images
  List<ImageModel> selectedImagesToUpload = [];

  // Last Fetched Time
  DateTime? lastFetchTime = DateTime.now();

  /// Lists of images for each category folder to reduice network calls
  final List<ImageModel> allImages = [];
  final List<ImageModel> allBannerImages = [];
  final List<ImageModel> allProductImages = [];
  final List<ImageModel> allBrandImages = [];
  final List<ImageModel> allCategoryImages = [];
  final List<ImageModel> allUserImages = [];

  /// --Change Selected Category--
  void changeCategory(MediaCategory category) {
    selectedPath = category;
    // update lastFetchTime depend on selected category
    lastFetchTime =
        _updateCorrespondingList(category).isNotEmpty
            ? _updateCorrespondingList(category).last.createdAt ??
                DateTime.now()
            : lastFetchTime;
    emit(SelectedCategoryState());
  }

  /// -------  // ------- Start of Drag and Drop images ------- // ------->
  // -- Drag and Drop Web--
  Future<void> dragDropImages({required DropzoneFileInterface file}) async {
    try {
      // Convert image to Uint8List
      final bytes = await dropzoneController.getFileData(file);
      // Check if bytes are not empty
      if (bytes.isNotEmpty) {
        // Pass Uint8List to ImageModel
        final image = ImageModel(
          url: '',
          folder: '',
          fileName: file.name,
          localImageToDisplay: Uint8List.fromList(bytes),
        );

        /// add image to list "add new image and ignored all previous images"
        ///
        selectedImagesToUpload.add(image);
        emit(SelectedImagesLoadedState());
      } else {
        emit(SelectedImagesFailedState());
      }
    } catch (e) {
      emit(SelectedImagesFailedState());
    }
  }

  // -- Drag and Drop Desktop--
  Future<void> dragDropImagesDisktop({required List<XFile> files}) async {
    try {
      for (var file in files) {
        // Convert image to Uint8List
        final Uint8List imageBytes = await file.readAsBytes();

        // check if bytes are not empty
        if (imageBytes.isNotEmpty) {
          // Pass Uint8List to ImageModel
          final image = ImageModel(
            url: '',
            folder: '',
            fileName: file.name,
            localImageToDisplay: Uint8List.fromList(imageBytes),
          );

          /// add image to list "add new image and ignored all previous images"
          ///
          selectedImagesToUpload.add(image);
        }
      }

      // check if bytes are not empty
      if (selectedImagesToUpload.isNotEmpty) {
        emit(SelectedImagesLoadedState());
      } else {
        emit(SelectedImagesFailedState());
      }
    } catch (e) {
      emit(SelectedImagesFailedState());
    }
  }

  /// -------  // ------- End of Drag and Drop Images ------- // ------->
  // ==================================================================================================//

  /// -------  // ------- Start of select local images ------- // ------->
  /// -- Select Local Images--
  Future<void> selectLocalImages() async {
    if (kIsWeb) {
      await selectLocalImagesInWeb();
    } else {
      await selectLocalImagesPlatforms();
    }
  }

  // -- Select Local Images In Web--
  Future<void> selectLocalImagesInWeb() async {
    try {
      // Pick files
      final files = await dropzoneController.pickFiles(
        multiple: true,
        mime: ['image/jpeg', 'image/png', 'image/jpg', 'image/webp'],
      );

      // Check if files are not empty
      if (files.isNotEmpty) {
        for (var file in files) {
          //print('File type: ${file.runtimeType}');
          final Uint8List bytes = await dropzoneController.getFileData(file);

          final image = ImageModel(
            url: '',
            folder: '',
            //file: file,
            fileName: file.name,
            localImageToDisplay: Uint8List.fromList(bytes),
          );

          selectedImagesToUpload.add(image);
        }

        emit(SelectedImagesLoadedState());
      } else {
        emit(SelectedImagesFailedState());
      }
    } catch (e) {
      emit(SelectedImagesFailedState());
    }
  }

  // --Select Local Images for Other Platforms--
  Future<void> selectLocalImagesPlatforms() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        allowedExtensions: ['jpeg', 'png', 'jpg', 'webp'],
        withData:
            true, // هذا يجعل file.bytes دائمًا يحتوي على البيانات بدون الحاجة إلى file.path.
      );

      if (result != null && result.files.isNotEmpty) {
        for (var file in result.files) {
          // convert to Uint8List
          Uint8List imageBytes;

          if (file.bytes != null) {
            imageBytes = file.bytes!;
          } else if (file.path != null) {
            imageBytes = await File(file.path!).readAsBytes();
          } else {
            debugPrint('No bytes or path found for file: ${file.name}');
            continue;
          }

          final image = ImageModel(
            url: '',
            folder: '',
            fileName: file.name,
            localImageToDisplay: Uint8List.fromList(imageBytes),
          );

          selectedImagesToUpload.add(image);
        }

        emit(SelectedImagesLoadedState());
      } else {
        emit(SelectedImagesFailedState());
      }
    } catch (e) {
      emit(SelectedImagesFailedState());
    }
  }

  /// -------  // -------  End of select local images ------- // ------->
  // ==================================================================================================//

  /// -------  // ------- Start of upload images ------- // ------->
  /// 1- Show Confirmation Dialog // 2- Upload Images
  // Show Confirmation Dialog
  Future<void> uploadImagesConfirmation() async {
    // confirm Selected Category
    if (selectedPath == MediaCategory.folders) {
      Loaders.warningSnackBar(
        title: 'Select Folder',
        message: 'Please select the Folder in Order to upload the images.',
      );
      return;
    }

    // show confirmation dialog
    CustomDialogs.defaultDialog(
      context: AppContext.context,
      title: 'Upload Images',
      content:
          'Are you sure you want to upload All the images in ${selectedPath.name.toUpperCase()} folder?',
      confirmText: 'Upload',
      onConfirm: () async => await uploadImages(),
    );
  }

  // --Upload Images specifiy category to DB--
  Future<void> uploadImages() async {
    // Remove Confirmation Dialog
    AppContext.context.popPage(AppContext.overlayContext);

    // Start loading
    emit(UploadedImagesLoadingState());

    // Get Selected Category
    MediaCategory selectedCategory = selectedPath;

    // Get the corresponding list to update "display specific images for selected category"
    List<ImageModel> targetList = _updateCorrespondingList(selectedCategory);

    // Create Lists to store successful and failed uploads
    List<ImageModel> successfulUploads = [];
    List<String> failedUploads = [];

    // Create List to store remaining images
    List<ImageModel> remainingImages = [];

    // Upload and add images to the targetList
    for (int i = selectedImagesToUpload.length - 1; i >= 0; i--) {
      final selectedImage = selectedImagesToUpload[i];
      final imageBytes = selectedImage.localImageToDisplay!;

      // Upload Image to Firebase Storage
      var result = await mediaRepository.uploadImages(
        fileBytes: imageBytes,
        path: getSelectedPath(),
        imageName: selectedImage.fileName,
      );

      result.fold(
        (error) {
          // Add failed image to the failed uploads list
          failedUploads.add(selectedImage.fileName);
          // Add failed image to the remaining images list to update selectedImagesToUpload
          remainingImages.add(selectedImage);
        },
        (uploadedImage) async {
          // Upload Image to Firestore
          uploadedImage.mediaCategory = selectedCategory.name;
          final id = await mediaRepository.uploadImageFileInDatabase(
            uploadedImage,
            path: getSelectedPath(),
          );
          uploadedImage.id = id;

          // // Remove uploaded image from the original list
          // selectedImagesToUpload.removeAt(i);
          selectedImagesToUpload.remove(selectedImage);
          emit(SelectedImagesLoadedState());

          // Add uploaded image to the successful uploads list
          successfulUploads.add(uploadedImage);
          debugPrint('Image uploaded successfully: ${uploadedImage.createdAt}');

          // Add uploaded image to the target list
          targetList.add(uploadedImage);
          lastFetchTime = lastFetchTime ?? DateTime.now();

          //after added .. emit the target list to update UI
          emit(FetchImagesSuccessState(targetList));
        },
      );
    }

    // Update selectedImagesToUpload
    selectedImagesToUpload = remainingImages;

    //  To Selected Images in UI
    emit(SelectedImagesLoadedState());

    // Stop loader
    TFullScreenLoader.stopLoading();

    // Check if there are any failed uploads
    if (failedUploads.isEmpty) {
      emit(
        UploadedImagesSuccessState(
          'Success!',
          'All images uploaded successfully.',
        ),
      );
    } else {
      emit(
        UploadImagesFailureState(
          ErrorModel(
            title: 'Some images failed!',
            message: 'Failed to upload: ${failedUploads.join(", ")}',
          ),
        ),
      );
    }
  }

  // Update Corresponding List
  List<ImageModel> _updateCorrespondingList(MediaCategory selectedCategory) {
    List<ImageModel> targetList;
    // check the selected category and update the corresponding list
    switch (selectedCategory) {
      case MediaCategory.folders:
        targetList = allImages;
        break;
      case MediaCategory.banners:
        targetList = allBannerImages;
        break;
      case MediaCategory.products:
        targetList = allProductImages;
        break;
      case MediaCategory.brands:
        targetList = allBrandImages;
        break;
      case MediaCategory.categories:
        targetList = allCategoryImages;
        break;
      case MediaCategory.users:
        targetList = allUserImages;
        break;
    }

    return targetList;
  }

  // Get Selected Path
  String getSelectedPath() {
    String path = '';
    switch (selectedPath) {
      case MediaCategory.brands:
        path = TTexts.brandsStoragePath;
        break;
      case MediaCategory.banners:
        path = TTexts.bannersStoragePath;
        break;
      case MediaCategory.products:
        path = TTexts.productsStoragePath;
        break;
      case MediaCategory.categories:
        path = TTexts.categoriesStoragePath;
        break;
      case MediaCategory.users:
        path = TTexts.usersStoragePath;
        break;
      default:
        path = 'Others';
    }

    return path;
  }

  // -------  // ------- End of upload images -------  // -------
  // ==================================================================================================//

  /// --Remove All Selected Images--
  void removeAllSelectedImages() {
    selectedImagesToUpload.clear();
    emit(SelectedImagesLoadedState());
  }

  // -----------  // ------- Fetch Images -------  // -------

  // Get Folder Images To storage image and reduce num of api calls
  List<ImageModel> _folderImages() {
    List<ImageModel> targetList = <ImageModel>[];
    if (selectedPath == MediaCategory.banners) {
      targetList = allBannerImages;
    } else if (selectedPath == MediaCategory.brands) {
      targetList = allBrandImages;
    } else if (selectedPath == MediaCategory.categories) {
      targetList = allCategoryImages;
    } else if (selectedPath == MediaCategory.products) {
      targetList = allProductImages;
    } else if (selectedPath == MediaCategory.users) {
      targetList = allUserImages;
    }
    return targetList;
  }

  /// --Fetch Images From Database--
  Future<void> fetchImagesFromDatabase(int? limit) async {
    debugPrint('🔍 fetchImagesFromDatabase triggered!');
    emit(FetchImagesLoadingState());

    // Get Folder Images
    List<ImageModel> targetList = <ImageModel>[];
    targetList = _folderImages();

    if (targetList.isNotEmpty) {
      emit(FetchImagesSuccessState(targetList));
      debugPrint('Images Already fetched from database: ${targetList.length}');
      return;
    }

    debugPrint('Images fetched from database: ${targetList.length}');

    // Fetch Images From Database
    var result = await mediaRepository.fetchImagesFromDatabase(
      selectedPath,
      path: getSelectedPath(),
      limit,
    );

    result.fold(
      (error) {
        debugPrint('Error fetching images from database: $error');
        emit(FetchImagesFailureState(error));
      },
      (images) {
        targetList.clear();
        targetList.addAll(images);
        lastFetchTime =
            images.isEmpty
                ? DateTime.now()
                : images.last.createdAt ?? DateTime.now();
        emit(FetchImagesSuccessState(targetList));
      },
    );
  }

  /// --Fetch More Images From Database--
  Future<void> fetchMoreImages(int limit) async {
    debugPrint('🔍 fetchMoreImages triggered!');

    // Get Folder Images
    List<ImageModel> targetList = <ImageModel>[];
    targetList = _folderImages();

    // Update lastFetchTime depend on targetList that fetched from database
    lastFetchTime = lastFetchTime ?? DateTime.now();

    // Check if targetList is empty
    if (targetList.isEmpty) {
      debugPrint('⚠️ Warning: No previous images found, using DateTime.now().');
    } else {
      debugPrint('✅ Using last createdAt: $lastFetchTime');
    }

    // Fetch Images From Database
    var result = await mediaRepository.fetchMoreImages(
      selectedPath,
      limit,
      path: getSelectedPath(),
      lastFetchTime ?? DateTime.now(),
    );

    result.fold(
      (error) {
        emit(FetchImagesFailureState(error));
      },
      (images) {
        lastFetchTime =
            images.isEmpty
                ? lastFetchTime
                : images.last.createdAt ?? DateTime.now();
        // Overide targetList
        targetList.addAll(images);
        emit(FetchImagesSuccessState(targetList));
      },
    );
  }

  /// -------  // ------- End of Fetch Images -------  // -------

  /// --Delete Image From Storage--
  /// 1-- Delete Confirmation Dialog--
  void deleteImageDialogConfiramtion(ImageModel image) async {
    // Delete Confirmation Dialog
    CustomDialogs.defaultDialog(
      context: AppContext.context,
      content: 'Are you sure you want to delete this image?',
      onConfirm: () async => await deleteImageFromStorage(image),
    );
  }

  // 2-- Delete Image--
  Future<void> deleteImageFromStorage(ImageModel image) async {
    debugPrint('🔍 deleteImageFromStorage triggered!');
    // Remove Confirmation Dialog
    AppContext.context.popPage(AppContext.overlayContext);

    // Start loading
    emit(DeleteImageLoadingState());

    // Delete Image
    var result = await mediaRepository.deleteImageFromStorage(image);

    // Get the corresponding folder images
    List<ImageModel> targetList = _folderImages();

    result.fold(
      (error) {
        debugPrint('Error deleting image: $error');
        // Remove Loader
        if (AppContext.overlayContext.mounted) {
          AppContext.overlayContext.popPage(AppContext.overlayContext);
        }
        //Loaders.warningSnackBar(message: error, title: 'Error deleting image');
        Loaders.warningSnackBar(
          message: 'Something went wrong while deleting image',
          title: 'Error deleting image',
        );
        emit(DeleteImageFailureState(error));
      },
      (success) {
        debugPrint('Image deleted successfully');
        // Remove Loader
        if (AppContext.overlayContext.mounted) {
          AppContext.overlayContext.popPage(AppContext.overlayContext);
        }
        //Loaders.customToast(message: 'Image deleted successfully');
        // Remove image from targetList
        targetList.remove(image);
        emit(DeleteImageSuccessState());
        Loaders.successSnackBar(
          title: 'Image Deleted',
          message: 'Image Successfully Deleted from your cloud storage',
        );
        emit(FetchImagesSuccessState(targetList));
      },
    );
  }

  /// -------  // ------- End of Delete Image -------  // -------
}
