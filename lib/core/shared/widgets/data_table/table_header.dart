// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';

class TableHeader extends StatelessWidget {
  final Function()? onPressed;
  final String? buttonText;

  final TextEditingController? searchController;
  final Function(String)? searchOnChanged;
  final bool showLeftWidget;

  const TableHeader({
    super.key,
    this.onPressed,
    this.buttonText = 'Add',
    this.searchController,
    this.searchOnChanged,
    this.showLeftWidget = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: DeviceUtilities.isDesktopScreen(context) ? 3 : 1,
          child:
              showLeftWidget
                  ? Row(
                    children: [
                      Flexible(
                        child: FittedBox(
                          child: SizedBox(
                            width:
                                DeviceUtilities.isMobileScreen(context)
                                    ? null
                                    : 200,
                            child: ElevatedButton(
                              onPressed: onPressed,
                              child: FittedBox(child: Text(buttonText!)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                  : const SizedBox.shrink(),
        ),
        const SizedBox(width: AppSizes.md),
        Expanded(
          flex: DeviceUtilities.isDesktopScreen(context) ? 2 : 1,
          child: TextFormField(
            controller: searchController,
            onChanged: searchOnChanged,
            decoration: const InputDecoration(
              hintText: 'Search here...',
              prefixIcon: Icon(Iconsax.search_normal),
            ),
          ),
        ),
      ],
    );
  }
}
