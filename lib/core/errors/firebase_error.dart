import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class FirebaseErrorHandler {
  // Singleton pattern for easy access throughout the app
  static final FirebaseErrorHandler _instance =
      FirebaseErrorHandler._internal();
  factory FirebaseErrorHandler() => _instance;
  FirebaseErrorHandler._internal();

  /// Handles all types of Firebase-related exceptions and returns a user-friendly message
  String handleError(dynamic error, [StackTrace? stackTrace]) {
    if (error is FirebaseException) {
      return _handleFirebaseException(error);
    } else if (error is SocketException) {
      return _handleSocketException(error);
    } else if (error is PlatformException) {
      return _handlePlatformException(error);
    } else if (error is HttpException) {
      return _handleHttpException(error);
    } else {
      return _handleGenericError(error, stackTrace);
    }
  }

  String _handleFirebaseException(FirebaseException e) {
    // You can add more specific Firebase error handling here
    return e.message ?? 'Firebase operation failed: ${e.code}';
  }

  String _handleSocketException(SocketException e) {
    return 'Network error: ${e.osError?.message ?? 'Please check your internet connection'}';
  }

  String _handlePlatformException(PlatformException e) {
    return 'Platform error: ${e.message ?? 'An unexpected platform error occurred'}';
  }

  String _handleHttpException(HttpException e) {
    return 'HTTP error: ${e.message}';
  }

  String _handleGenericError(dynamic error, StackTrace? stackTrace) {
    // Log the full error and stack trace for debugging
    debugPrint('Unexpected error: $error');
    debugPrint('Stack trace: $stackTrace');
    return 'An unexpected error occurred. Please try again.';
  }

  /// Helper method to transform the error handling into Either pattern
  Either<String, R> handleErrorEither<R>(R Function() operation) {
    try {
      return Right(operation());
    } catch (e, stackTrace) {
      return Left(handleError(e, stackTrace));
    }
  }

  /// Async version of handleErrorEither for async operations
  Future<Either<String, R>> handleErrorEitherAsync<R>(
    Future<R> Function() operation,
  ) async {
    try {
      return Right(await operation());
    } catch (e, stackTrace) {
      return Left(handleError(e, stackTrace));
    }
  }
}

// Helper function for debug printing (replace with your preferred logging)
void debugPrint(String message) {
  // You can replace this with your actual logging mechanism
  if (kDebugMode) {
    print(message);
  }
}
