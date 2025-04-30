import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:t_store_admin_panel/data/services/authentication/authentication_firebase_services.dart';
import 'package:t_store_admin_panel/domain/repositories/authentication/authentication_repo.dart';

class AuthenticationRepoImpl extends AuthenticationRepo {
  final AuthFirebaseServices _services;

  AuthenticationRepoImpl(this._services);

  @override
  Future<Either<String, UserCredential>> signIn(
    String email,
    String password,
  ) async {
    try {
      var user = await _services.signIn(email, password);
      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, UserCredential>> signUp(
    String email,
    String password,
  ) async {
    try {
      var user = await _services.signUp(email, password);
      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }

  // RESET PASSWORD
}
