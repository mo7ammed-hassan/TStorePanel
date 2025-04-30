import 'package:dartz/dartz.dart';
import 'package:t_store_admin_panel/data/models/user/user_model.dart';
import 'package:t_store_admin_panel/data/services/user/user_firebase_services.dart';
import 'package:t_store_admin_panel/domain/repositories/user/user_repo.dart';

class UserRepoImpl extends UserRepo {
  final UserFirebaseServices _userFirebaseServices;

  UserRepoImpl(this._userFirebaseServices);
  @override
  Future<Either<String, UserModel>> fetchUserDetails() async {
    return await _userFirebaseServices.fetchUserDetails();
  }

  @override
  Future<Either<String, Unit>> signOut() async {
    return await _userFirebaseServices.signOut();
  }
}
