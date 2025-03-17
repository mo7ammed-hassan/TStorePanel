part of 'user_cubit.dart';

sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoadingState extends UserState {}

final class UserErrorState extends UserState {
  final String error;
  UserErrorState(this.error);
}

final class UserLoadedState extends UserState {
  final UserModel user;
  UserLoadedState(this.user);
}

final class UserSignedOutState extends UserState {}
