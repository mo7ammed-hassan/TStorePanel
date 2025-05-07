import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/utils/helpers/app_context.dart';
import 'package:t_store_admin_panel/data/models/user/user_model.dart';
import 'package:t_store_admin_panel/domain/repositories/user/user_repo.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this._userRepo) : super(UserInitial()) {
    fetchUserDetails();
  }

  final UserRepo _userRepo;
  UserModel userData = UserModel.empty();

  Future<void> fetchUserDetails() async {
    emit(UserLoadingState());

    var result = await _userRepo.fetchUserDetails();
    result.fold((error) => emit(UserErrorState(error)), (user) {
      userData = user;
      emit(UserLoadedState(user));
    });
  }

  // 🔄 Reset UserCubit state
  Future<void> signOut() async {
    var result = await _userRepo.signOut();
    result.fold((error) => emit(UserErrorState(error)), (_) {
      emit(UserInitial());

      // Start New Session
      AppContext.navigatorKey.currentState?.pushNamedAndRemoveUntil(
        Routes.login,
        (route) => false,
      );
    });
  }
}
