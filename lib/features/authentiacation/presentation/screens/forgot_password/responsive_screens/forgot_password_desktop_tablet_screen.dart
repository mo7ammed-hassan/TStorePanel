import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/login_template.dart';
import 'package:t_store_admin_panel/features/authentiacation/presentation/widgets/forgot_password/header_and_form.dart';

class ForgotPasswordDesktopTabletScreen extends StatelessWidget {
  const ForgotPasswordDesktopTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginTemplate(child: HeaderAndFormForgetPassword());
  }
}
