import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/app_context.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/core/utils/utils/loaders/circular_loader.dart';

class CustomDialogs {
  static showConfirmationDialog({
    required String title,
    required String message,
    required String confirmButtonText,
    required String cancelButtonText,
  }) {
    return showDialog<bool>(
      context: AppContext.context,
      barrierDismissible: false,
      builder:
          (context) => PopScope(
            canPop: false,
            child: AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                TextButton(
                  child: Text(cancelButtonText),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                TextButton(
                  child: Text(confirmButtonText),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            ),
          ),
    );
  }

  static Future showCircularLoader() {
    final isDark = HelperFunctions.isDarkMode(AppContext.context);

    return showDialog(
      context: AppContext.context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            insetPadding: const EdgeInsets.all(0),
            shape: const CircleBorder(),
            backgroundColor:
                isDark ? AppColors.black : AppColors.primaryBackground,
            content: const TCircularLoader(),
          ),
    );
  }

  static void hideLoader() {
    if (Navigator.canPop(AppContext.context)) {
      Navigator.pop(AppContext.context);
    }
  }
}
