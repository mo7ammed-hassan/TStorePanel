// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';

class TableHeader extends StatelessWidget {
  final Function()? onPressed;
  final String buttonText;

  final TextEditingController? searchController;
  final Function(String)? searchOnChanged;

  const TableHeader({
    super.key,
    this.onPressed,
    required this.buttonText,
    this.searchController,
    this.searchOnChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: DeviceUtility.isDesktopScreen(context) ? 3 : 1,
          child: Row(
            children: [
              Flexible(
                child: FittedBox(
                  child: SizedBox(
                    //width: 200,
                    child: ElevatedButton(
                      onPressed: onPressed,
                      child: FittedBox(child: Text(buttonText)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSizes.md),
        Expanded(
          flex: DeviceUtility.isDesktopScreen(context) ? 2 : 1,
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
