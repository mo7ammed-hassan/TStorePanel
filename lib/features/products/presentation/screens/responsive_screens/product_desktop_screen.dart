import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/bottom_sheets/media_buttom_sheet.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';

class ProductDesktopScreen extends StatelessWidget {
  const ProductDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.spaceBtwItems),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: AppSizes.buttonWidth * 1.5,
                    child: ElevatedButton(
                      onPressed: () => showMediaButtomSheet(context),
                      child: const Text('Show Media Sheet'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
