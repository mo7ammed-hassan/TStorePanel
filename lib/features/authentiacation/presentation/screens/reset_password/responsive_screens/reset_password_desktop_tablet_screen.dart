import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/login_template.dart';
import 'package:t_store_admin_panel/features/authentiacation/presentation/widgets/reset_password/reset_password_widget.dart';

class ResetPasswordDesktopTabletScreen extends StatelessWidget {
  const ResetPasswordDesktopTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginTemplate(child: ResetPasswordWidget());
  }
}
