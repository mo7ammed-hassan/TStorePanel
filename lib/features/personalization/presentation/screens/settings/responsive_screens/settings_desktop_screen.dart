import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';

class SettingsDesktopScreen extends StatelessWidget {
  const SettingsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.spaceBtwItems),
          child: Row(
            children: [
              // Profile Image
              Expanded(child: RoundedContainer()),
              SizedBox(width: AppSizes.spaceBtwSections),

              // Profile Details
              Expanded(flex: 2, child: RoundedContainer()),
            ],
          ),
        ),
      ),
    );
  }
}
