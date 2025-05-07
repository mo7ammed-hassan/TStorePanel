import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/utils/helpers/app_context.dart';
import 'package:t_store_admin_panel/data/services/user/user_manager.dart';
import 'package:t_store_admin_panel/features/authentiacation/presentation/screens/login/login_screen.dart';

class RouteMiddleware {
  static bool isAuthenticated() {
    // Implement authentication logic (Example: Check user login state)
    return getIt<UserManager>().isAuthenticated;
  }

  /// Handles route protection logic
  static Route<dynamic> protectRoute(
    RouteSettings settings,
    Widget Function(BuildContext) pageBuilder,
  ) {
    final isIOS = defaultTargetPlatform == TargetPlatform.iOS;

    // Get the requested route
    final Uri uri = Uri.parse(settings.name ?? '');
    final path =
        (uri.pathSegments.length > 1) ? '/${uri.pathSegments[0]}' : uri.path;

    // Authentication check
    if (!isAuthenticated() && !_isAuthScreen(path)) {
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   navigatorKey.currentState?.pushReplacementNamed(Routes.login);
      // });
      Future.microtask(() {
        AppContext.navigatorKey.currentState?.popUntil(
          (route) => route.isFirst,
        );
        AppContext.navigatorKey.currentState?.pushReplacementNamed(
          Routes.login,
        );
      });

      return _buildRoute(isIOS, settings, (_) => const LoginScreen());
    }

    // Proceed with the requested route
    return _buildRoute(isIOS, settings, pageBuilder);
  }

  /// Helper method to determine if a route belongs to authentication screens
  static bool _isAuthScreen(String? route) {
    return route == Routes.login ||
        route == Routes.forgotPassword ||
        route == Routes.resetPassword;
  }

  /// Builds a platform-specific route
  static Route<dynamic> _buildRoute(
    bool isIOS,
    RouteSettings settings,
    Widget Function(BuildContext) pageBuilder,
  ) {
    return isIOS
        ? CupertinoPageRoute(builder: pageBuilder, settings: settings)
        : MaterialPageRoute(builder: pageBuilder, settings: settings);
  }
}
