part of 'sign_in_cubit.dart';

@immutable
sealed class SignInState {}

final class SignInInitial extends SignInState {}

final class SignInLoadingState extends SignInState {
  final String message;
  SignInLoadingState(this.message);
}

final class SignInErrorState extends SignInState {
  final String error;
  SignInErrorState(this.error);
}

final class SignInSuccessState extends SignInState {}

final class TogglePasswordVisibilityState extends SignInState {
  final bool isPasswordVisible;
  TogglePasswordVisibilityState(this.isPasswordVisible);
}

final class ToggleCheckBoxVisibilityState extends SignInState {
  final bool isCheckBoxVisible;
  ToggleCheckBoxVisibilityState(this.isCheckBoxVisible);
}
