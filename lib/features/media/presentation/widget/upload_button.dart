import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';

class UploadButton extends StatelessWidget {
  const UploadButton({super.key, this.onPressed});
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizes.buttonWidth + 10,
      child: ElevatedButton(onPressed: onPressed, child: const Text('Upload')),
    );
  }
}
