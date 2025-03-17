import 'package:flutter/material.dart';

class AppContext {
  AppContext._();

  // singleton instance
  static final AppContext instance = AppContext._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext get context {
    if (navigatorKey.currentState == null) {
      throw Exception('Context is not available yet!');
    }

    return navigatorKey.currentState!.context;
  }

  static BuildContext get overlayContext {
    if (navigatorKey.currentState == null) {
      throw Exception('Context is not available yet!');
    }

    return navigatorKey.currentState!.overlay!.context;
  }
}
