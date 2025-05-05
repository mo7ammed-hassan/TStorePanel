import 'package:flutter/material.dart';

extension NavigationX on BuildContext {
  void removeAll(Widget page) {
    Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (context) => page),
      (Route<dynamic> route) => false, // remove all pages from memory "stack"
    );
  }

  void removeAllSaveStack(Widget page) {
    Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (context) => page),
      (Route<dynamic> route) =>
          true, // not remove all pages from memory "stack"
    );
  }

  void removePage(Widget page) {
    Navigator.pop(this); // remove the current page from memory
  }

  void popPage(BuildContext context) {
    Navigator.pop(context); // remove the current page from memory
  }

  void pushPage(Widget page) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => page));
  }

  void pushScalePage(Widget page) {
    Navigator.push(
      this,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (context, animation, secondaryAnimation) {
          return page;
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: Tween(begin: 0.3, end: 1.0).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  void pushNamedPage(String route, {Object? arguments}) =>
      Navigator.pushNamed(this, route, arguments: arguments);
  void pushReplacementNamedPage(String route) =>
      Navigator.pushReplacementNamed(this, route);
  void pushNamedAndRemoveUntilPage(String route) =>
      Navigator.pushNamedAndRemoveUntil(this, route, (route) => false);
  void pushNamedAndRemoveUntilPageSaveStack(String route) =>
      Navigator.pushNamedAndRemoveUntil(this, route, (route) => true);
}
