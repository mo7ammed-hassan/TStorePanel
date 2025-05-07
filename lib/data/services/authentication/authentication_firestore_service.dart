// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:t_store_admin_panel/core/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:t_store_admin_panel/core/utils/exceptions/format_exceptions.dart';
import 'package:t_store_admin_panel/core/utils/exceptions/platform_exceptions.dart';
import 'package:t_store_admin_panel/data/models/user/user_model.dart';
import 'package:t_store_admin_panel/data/services/user/user_manager.dart';

abstract class AuthFirestoreService {
  // CREATE USER
  Future<void> createUser(UserModel user);
}

class AuthFirestoreServiceImpl implements AuthFirestoreService {
  final UserManager _userManager;
  final _database = FirebaseFirestore.instance;

  AuthFirestoreServiceImpl(this._userManager);

  @override
  Future<void> createUser(UserModel user) async {
    try {
      await _database
          .collection('Users')
          .doc(_userManager.user!.uid)
          .set(user.toJson());
      return;
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on TFormatException catch (_) {
      throw const TFormatException();
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. please try again';
    }
  }
}
