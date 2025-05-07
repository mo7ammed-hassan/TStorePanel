import 'package:firebase_auth/firebase_auth.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/utils/helpers/app_context.dart';

class UserManager {
  // Firebase Auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get Authds
  FirebaseAuth get auth => _auth;

  // Get Authenticated User Data
  User? get user => _auth.currentUser;

  // Get IsAuthenticated User
  bool get isAuthenticated => _auth.currentUser != null;

  // OnReady - Ensure Firebase Auth Persistence is set
  Future<void> onReady() async {
    try {
      await _auth.setPersistence(Persistence.LOCAL);
      // debugPrint("✅ Firebase Auth persistence set successfully.");
    } catch (e) {
      // debugPrint("❌ Error setting persistence: $e");
    }
  }

  /// SignOut
  /// 🔄 Reset UserManager and UserCubit to clean user data completely
  Future<void> signOut() async {
    /// SignOut
    await _auth.signOut();

    /// 🔄 Function to reset the user manager after logout
    Future.delayed(Duration.zero, resetUserCubit);

    /// 🔄 Delay reset to avoid conflicts
    Future.delayed(Duration.zero, resetUserManager);
  }

  // Function to determine the relevant screen and redirect accordingly
  void screenRedirect() {
    final user = _auth.currentUser;

    // If user is authenticated (Logged In)
    if (user != null) {
      AppContext.navigatorKey.currentState?.pushReplacementNamed(
        Routes.dashboard,
      );
    } else {
      AppContext.navigatorKey.currentState?.pushReplacementNamed(Routes.login);
    }
  }
}
