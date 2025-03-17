import 'package:either_dart/either.dart';
import 'package:t_store_admin_panel/data/models/user/user_model.dart';

abstract class UserRepo {
  // Fetch User details from firestore
  Future<Either<String, UserModel>> fetchUserDetails();

  // Sign Out
  Future<Either<String, void>> signOut();
}
