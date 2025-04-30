import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepo {
  Future<Either<String, UserCredential>> signIn(String email, String password);

  Future<Either<String, UserCredential>> signUp(String email, String password);

  // RESET PASSWORD
}
