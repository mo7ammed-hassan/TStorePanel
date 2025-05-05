import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';

/// A circular loader widget with customizable foreground and background colors.
class TCircularLoader extends StatelessWidget {
  const TCircularLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 75,
      height: 75,
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ), // Circular loader
      ),
    );
  }
}
