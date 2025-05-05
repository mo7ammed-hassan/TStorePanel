import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/helpers/app_context.dart';
import 'package:t_store_admin_panel/core/utils/helpers/navigation.dart';
import '../constants/colors.dart';
import '../helpers/helper_functions.dart';
import '../loaders/animation_loader.dart';

/// A utility class for managing a full-screen loading dialog.
class FullScreenLoaderWidget {
  /// Open a full-screen loading dialog with a given text and animation.
  /// This method doesn't return anything.
  ///
  /// Parameters:
  ///   - text: The text to be displayed in the loading dialog.
  ///   - animation: The Lottie animation to be shown.
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: AppContext.overlayContext,
      barrierDismissible:
          false, // The dialog can't be dismissed by tapping outside it
      builder:
          (_) => PopScope(
            canPop: false, // Disable popping with the back button
            child: Container(
              color:
                  HelperFunctions.isDarkMode(AppContext.context)
                      ? AppColors.dark
                      : AppColors.white,
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: TAnimationLoaderWidget(text: text, animation: animation),
              ),
            ),
          ),
    );
  }

  /// Stop the currently open loading dialog.
  /// This method doesn't return anything.
  static stopLoading() {
    AppContext.overlayContext.popPage(AppContext.overlayContext);
  }
}
