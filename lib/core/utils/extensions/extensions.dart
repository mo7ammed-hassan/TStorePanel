import 'package:flutter/material.dart';

extension BuildXContext on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}
