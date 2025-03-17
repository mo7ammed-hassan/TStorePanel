import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/app_context.dart';

import '../constants/colors.dart';
import '../helpers/helper_functions.dart';

class Loaders {
  static hideSnackBar() =>
      ScaffoldMessenger.of(AppContext.context).hideCurrentSnackBar();

  static customToast({required message, bool isMedium = true}) {
    ScaffoldMessenger.of(AppContext.context).showSnackBar(
      SnackBar(
        width:
            DeviceUtility.isDesktopScreen(AppContext.context)
                ? MediaQuery.of(AppContext.context).size.width * 0.25
                : null,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        duration: const Duration(milliseconds: 600),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color:
                HelperFunctions.isDarkMode(AppContext.context)
                    ? AppColors.darkerGrey.withValues(alpha: 0.9)
                    : AppColors.grey.withValues(alpha: 0.9),
          ),
          child: Center(
            child: Text(
              message,
              style:
                  isMedium
                      ? Theme.of(AppContext.context).textTheme.bodyMedium
                      : Theme.of(AppContext.context).textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  static successSnackBar({
    required String title,
    String message = '',
    int duration = 3,
  }) {
    _showSnackBar(title, message, AppColors.primary, Iconsax.check);
  }

  static warningSnackBar({required String title, String message = ''}) {
    _showSnackBar(title, message, Colors.orange, Iconsax.warning_2);
  }

  static errorSnackBar({required String title, String message = ''}) {
    _showSnackBar(title, message, Colors.red.shade600, Iconsax.warning_2);
  }

  static void _showSnackBar(
    String title,
    String message,
    Color bgColor,
    IconData icon,
  ) {
    ScaffoldMessenger.of(AppContext.context).showSnackBar(
      SnackBar(
        width:
            DeviceUtility.isDesktopScreen(AppContext.context)
                ? MediaQuery.of(AppContext.context).size.width * 0.25
                : null,
        behavior: SnackBarBehavior.floating,
        backgroundColor: bgColor,
        duration: const Duration(seconds: 3),
        // margin: const EdgeInsets.all(20),
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '$title\n$message',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
