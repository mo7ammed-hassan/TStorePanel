import 'package:flutter_bloc/flutter_bloc.dart';
part 'media_action_state.dart';

class MediaActionCubit extends Cubit<MediaActionState> {
  MediaActionCubit() : super(MediaActionInitial());

  bool showMediaUploaderSection = false;
  bool showImagesUploaderSection = false;

  void toggleMediaUploaderSection() {
    showMediaUploaderSection = !showMediaUploaderSection;
    emit(ToggleMediaUploaderSection(showMediaUploaderSection));
  }
}
