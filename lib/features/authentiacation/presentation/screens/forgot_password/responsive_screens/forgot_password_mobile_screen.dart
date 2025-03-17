import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/authentiacation/presentation/widgets/forgot_password/header_and_form.dart';

class ForgotPasswordMobileScreen extends StatelessWidget {
  const ForgotPasswordMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppSizes.defaultSpace),
            child: HeaderAndFormForgetPassword(),
          ),
        ),
      ),
    );
  }
}
