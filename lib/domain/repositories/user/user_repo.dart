import 'package:dartz/dartz.dart';
import 'package:t_store_admin_panel/data/models/user/user_model.dart';

abstract class UserRepo {
  Future<Either<String, UserModel>> fetchUserDetails();

  Future<Either<String, Unit>> signOut();
}
