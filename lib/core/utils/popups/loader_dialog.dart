import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/helpers/app_context.dart';
import 'package:t_store_admin_panel/core/utils/loaders/circular_loader.dart';

class LoaderDialog {
  static Future showLoaderDialog() {
    return showDialog(
      context: AppContext.overlayContext,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: PopScope(
            canPop: false,
            child: SizedBox(
              width: DeviceUtilities.isDesktopScreen(context) ? 150 : 80,
              height: DeviceUtilities.isDesktopScreen(context) ? 150 : 80,
              child: const TCircularLoader(),
            ),
          ),
        );
      },
    );
  }
}
