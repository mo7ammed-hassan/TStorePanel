import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/authentiacation/presentation/widgets/login/login_form.dart';
import 'package:t_store_admin_panel/features/authentiacation/presentation/widgets/login/login_header.dart';

class LoginMobileScreen extends StatelessWidget {
  const LoginMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: AppSizes.appBarHeight,
          left: AppSizes.defaultSpace,
          right: AppSizes.defaultSpace,
          bottom: AppSizes.defaultSpace,
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                // Header
                LoginHeader(),

                // Form
                LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
