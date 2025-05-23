import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/authentiacation/presentation/widgets/reset_password/reset_password_widget.dart';

class ResetPasswordMobileScreen extends StatelessWidget {
  const ResetPasswordMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppSizes.defaultSpace),
            child: ResetPasswordWidget(),
          ),
        ),
      ),
    );
  }
}
