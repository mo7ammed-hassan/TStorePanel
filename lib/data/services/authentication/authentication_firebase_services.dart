import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:t_store_admin_panel/core/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:t_store_admin_panel/core/utils/exceptions/format_exceptions.dart';
import 'package:t_store_admin_panel/core/utils/exceptions/platform_exceptions.dart';
import 'package:t_store_admin_panel/data/services/user/user_manager.dart';

abstract class AuthFirebaseServices {
  // LOGIN
  Future<UserCredential> signIn(String email, String password);

  // REGISTER
  Future<UserCredential> signUp(String email, String password);

  // LOGOUT
  Future<void> signOut();

  // RESET PASSWORD

  // Already Logged In
  bool alreadyLoggedIn();
}

class AuthFirebaseServicesImpl implements AuthFirebaseServices {
  final UserManager _userManager;

  AuthFirebaseServicesImpl(this._userManager);

  @override
  Future<UserCredential> signIn(String email, String password) async {
    try {
      debugPrint("🔹 Trying to sign in with: $email");
      final userCredential = await _userManager.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint("✅ Signed in successfully: ${userCredential.user?.uid}");
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code);
    } on TFormatException catch (e) {
      throw e.toString();
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e, stackTrace) {
      debugPrint("❌ Unexpected Error: $e\n$stackTrace");
      throw Exception('Something went wrong. Please try again.');
    }
  }

  @override
  Future<UserCredential> signUp(String email, String password) async {
    try {
      return await _userManager.auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code);
    } on TFormatException catch (e) {
      throw e.toString();
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e, stackTrace) {
      debugPrint("❌ Unexpected Error: $e\n$stackTrace");
      throw Exception('Something went wrong. Please try again.');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _userManager.signOut();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code);
    } on TFormatException catch (e) {
      throw e.toString();
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e, stackTrace) {
      debugPrint("❌ Unexpected Error: $e\n$stackTrace");
      throw Exception('Something went wrong. Please try again.');
    }
  }

  @override
  bool alreadyLoggedIn() {
    return _userManager.auth.currentUser != null ? true : false;
  }
}
