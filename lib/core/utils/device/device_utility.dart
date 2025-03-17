import 'dart:io';

import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/helpers/extintions/extentions.dart';

class DeviceUtility {
  static bool isIOS() => Platform.isIOS;
  static bool isAndroid() => Platform.isAndroid;

  static bool isMobileScreen(BuildContext context) => context.screenwidth < 768;
  static bool isTabletScreen(BuildContext context) =>
      context.screenwidth >= 768 && context.screenwidth < 1366;
  static bool isDesktopScreen(BuildContext context) =>
      context.screenwidth >= 1366;
}
