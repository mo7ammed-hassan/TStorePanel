import 'package:firebase_auth/firebase_auth.dart';
import 'package:either_dart/either.dart';

abstract class AuthenticationRepo {
  // LOGIN
  Future<Either<String, UserCredential>> signIn(String email, String password);

  // REGISTER
  Future<Either<String, UserCredential>> signUp(String email, String password);

  // RESET PASSWORD

  
}
