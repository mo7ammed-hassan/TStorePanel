import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';

/// Template for login page layout
class LoginTemplate extends StatelessWidget {
  const LoginTemplate({super.key, required this.child});

  /// The Widget that represents the login page layout
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 550,
        child: SingleChildScrollView(
          child: Card(
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.only(
                top: AppSizes.appBarHeight,
                bottom: AppSizes.defaultSpace,
                left: AppSizes.defaultSpace,
                right: AppSizes.defaultSpace,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
                color: AppColors.white,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
