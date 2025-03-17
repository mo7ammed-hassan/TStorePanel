import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/data/models/user/user_model.dart';
import 'package:t_store_admin_panel/data/services/user/user_firebase_services.dart';
import 'package:t_store_admin_panel/domain/repositories/user/user_repo.dart';

class UserRepoImpl extends UserRepo {
  final UserFirebaseServices _userFirebaseServices;

  UserRepoImpl(this._userFirebaseServices);
  @override
  Future<Either<String, UserModel>> fetchUserDetails() async {
    try {
      final user = await _userFirebaseServices.fetchUserDetails();

      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> signOut() async {
    try {
      await _userFirebaseServices.signOut();
      return const Right(null);
    } catch (e) {
      debugPrint("❌ Error signing out: $e");
      return Left(e.toString());
    }
  }
}
