import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/login_template.dart';
import 'package:t_store_admin_panel/features/authentiacation/presentation/widgets/login/login_form.dart';
import 'package:t_store_admin_panel/features/authentiacation/presentation/widgets/login/login_header.dart';

class LoginDesktopTabletScreen extends StatelessWidget {
  const LoginDesktopTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginTemplate(
      child: Center(
        child: Column(
          children: [
            // Headers
            LoginHeader(),

            // Form
            LoginForm(),
          ],
        ),
      ),
    );
  }
}
