import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:t_store_admin_panel/core/errors/firebase_error.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/collection_constants.dart';
import 'package:t_store_admin_panel/data/models/user/user_model.dart';
import 'package:t_store_admin_panel/data/services/user/user_manager.dart';

abstract class UserFirebaseServices {
  Future<Either<String, UserModel>> fetchUserDetails();

  Future<Either<String, Unit>> signOut();
}

class UserFirebaseServicesImpl implements UserFirebaseServices {
  final UserManager _userManager;
  final _database = FirebaseFirestore.instance;
  final FirebaseErrorHandler _errorHandler = FirebaseErrorHandler();

  UserFirebaseServicesImpl(this._userManager);

  @override
  Future<Either<String, UserModel>> fetchUserDetails() async {
    try {
      final docSnapshot =
          await _database
              .collection(CollectionConstants.users)
              .doc(_userManager.user!.uid)
              .get();

      return Right(UserModel.fromJson(docSnapshot));
    } catch (e) {
      return Left(_errorHandler.handleError(e));
    }
  }

  @override
  Future<Either<String, Unit>> signOut() async {
    try {
      await _userManager.signOut();
      return const Right(unit);
    } catch (e) {
      throw _errorHandler.handleError(e);
    }
  }
}
