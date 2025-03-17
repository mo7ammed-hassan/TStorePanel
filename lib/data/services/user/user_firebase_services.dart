// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:t_store_admin_panel/core/utils/utils/exceptions/format_exceptions.dart';
import 'package:t_store_admin_panel/core/utils/utils/exceptions/platform_exceptions.dart';

import 'package:t_store_admin_panel/data/models/user/user_model.dart';
import 'package:t_store_admin_panel/data/services/user/user_manager.dart';

abstract class UserFirebaseServices {
  // Fetch user details
  Future<UserModel> fetchUserDetails();

  // SignOut
  Future<void> signOut();
}

class UserFirebaseServicesImpl implements UserFirebaseServices {
  final UserManager _userManager;
  final _database = FirebaseFirestore.instance;

  UserFirebaseServicesImpl(this._userManager);

  @override
  Future<UserModel> fetchUserDetails() async {
    try {
      final docSnapshot =
          await _database.collection('Users').doc(_userManager.user!.uid).get();
      return UserModel.fromJson(docSnapshot);
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
}
