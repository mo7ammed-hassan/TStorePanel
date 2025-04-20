import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/utils/storage/flutter_secure_storage.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/enums.dart';
import 'package:t_store_admin_panel/data/models/user/user_model.dart';
import 'package:t_store_admin_panel/data/services/authentication/authentaication_local_data_source.dart';
import 'package:t_store_admin_panel/data/services/authentication/authentication_firestore_service.dart';
import 'package:t_store_admin_panel/data/services/user/user_manager.dart';
import 'package:t_store_admin_panel/domain/repositories/authentication/authentication_repo.dart';
import 'package:t_store_admin_panel/domain/repositories/user/user_repo.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._authRepo, this._storeService) : super(SignInInitial());

  final AuthenticationRepo _authRepo;
  final AuthFirestoreService _storeService;
  final UserManager _userManager = getIt<UserManager>();

  /// Check internet connection
  final Connectivity _connectivity = Connectivity();

  /// toggle password visibility & check box visibility
  bool isPasswordVisible = false;
  bool isCheckBoxVisible = false;

  /// Controllers & Keys
  final email = TextEditingController();
  final password = TextEditingController();
  final loginKey = GlobalKey<FormState>();

  // Storage
  final _storage = FlutterSecureStorageUtils.instance;

  /// Check form validation
  bool validateForm() {
    return loginKey.currentState?.validate() ?? false;
  }

  // show email and password that is storage in get storage
  Future<void> getStorageEmailAndPassword() async {
    email.text = await _storage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = await _storage.read('REMEMBER_ME_PASSWORD') ?? '';
  }

  /// SIGN IN WITH EMAIL & PASSWORD
  Future<void> signIn() async {
    // Check internet connection
    _monitorConnection();

    // Check form validation
    if (!validateForm()) return;

    if (isCheckBoxVisible) {
      _storage.write('REMEMBER_ME_EMAIL', email.text.trim());
      _storage.write('REMEMBER_ME_PASSWORD', password.text.trim());
    } else {
      _storage.delete('REMEMBER_ME_EMAIL');
      _storage.delete('REMEMBER_ME_PASSWORD');
    }

    // Start loading
    emit(SignInLoadingState('Logging You In...'));

    /// Login User using email & password Auth

    // final signInResult = await _authRepo.signIn(
    //   email.text.trim(),
    //   password.text.trim(),
    // );
    // signInResult.fold((error) => emit(SignInErrorState(error)), (user) async {
    //   // Fetch User details from firestore
    //   final userResult = await getIt<UserRepo>().fetchUserDetails();
    //   userResult.fold((error) => emit(SignInErrorState(error)), (user) async {
    //     if (user.role != AppRole.admin) {
    //       await _userManager.signOut();
    //       emit(
    //         SignInErrorState(
    //           'You are not authorized or do not have the required permissions to access. Please contact the administrator.',
    //         ),
    //       );
    //     } else {
    //       emit(SignInSuccessState());
    //       // _userManager.screenRedirect();
    //     }
    //   });
    // });

    final signInResult = await _authRepo.signIn(
      email.text.trim(),
      password.text.trim(),
    );
    if (signInResult.isLeft) {
      emit(SignInErrorState(signInResult.fold((error) => error, (r) => '')));
      return;
    }

    final userResult = await getIt<UserRepo>().fetchUserDetails();
    if (userResult.isLeft) {
      emit(SignInErrorState(userResult.fold((error) => error, (r) => '')));
      return;
    }

    final user = userResult.fold((l) => null, (userModle) => userModle);
    if (user?.role != AppRole.admin) {
      await _userManager.signOut();
      emit(SignInErrorState('You are not authorized'));
      return;
    }
    await AuthLocalDataSource.setLoggedIn(true);
    emit(SignInSuccessState());
  }

  /// HANDLE REGISTER ADMIN
  Future<void> handleRegisterAdmin() async {
    // Check internet connection
    _monitorConnection();

    // Check form validation
    if (!validateForm()) return;

    // Start loading
    emit(SignInLoadingState('Registering Admin Account...'));

    /// Register user using email & password
    var result = await _authRepo.signUp(
      email.text.trim(),
      password.text.trim(),
    );

    result.fold(
      (error) {
        emit(SignInErrorState(error));
      },
      (user) async {
        // Get user ID
        final userId = _userManager.user!.uid;

        // Create Admin Record in firestore
        await _storeService.createUser(
          UserModel(
            email: email.text,
            userID: userId,
            firstName: 'Mohamed',
            lastName: 'Hassan',
            role: AppRole.admin,
            createdAt: DateTime.now(),
          ),
        );
        await AuthLocalDataSource.setLoggedIn(true);
        // End loading
        emit(SignInSuccessState());

        // // Redirect to home screen
        // _userManager.screenRedirect();
      },
    );
  }

  ///  Redirect to home screen
  void redirect() => _userManager.screenRedirect();

  /// Toggle Password
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(TogglePasswordVisibilityState(isPasswordVisible));
  }

  /// Toggle Check Box
  void toggleCheckBoxVisibility() {
    isCheckBoxVisible = !isCheckBoxVisible;
    emit(ToggleCheckBoxVisibilityState(isCheckBoxVisible));
  }

  /// Monitor Connection
  void _monitorConnection() {
    _connectivity.onConnectivityChanged.listen((result) {
      if (result.contains(ConnectivityResult.none)) {
        emit(SignInErrorState('No Internet Connection'));
      }
    });
  }

  /// On Close
  @override
  Future<void> close() {
    email.dispose();
    password.dispose();
    return super.close();
  }
}
