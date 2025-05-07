import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';

class TTableActionButtons extends StatelessWidget {
  const TTableActionButtons({
    super.key,
    this.view = false,
    this.edit = true,
    this.delete = true,
    this.onViewPressed,
    this.onEditPressed,
    this.onDeletePressed,
  });

  final bool view;
  final bool edit;
  final bool delete;
  final Function()? onViewPressed;
  final Function()? onEditPressed;
  final Function()? onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (view)
          Expanded(
            child: IconButton(
              icon: const Icon(Iconsax.eye),
              onPressed: onViewPressed,
              color: AppColors.darkerGrey,
            ),
          ),
        if (edit)
          Expanded(
            child: IconButton(
              icon: const Icon(Iconsax.pen_add),
              onPressed: onEditPressed,
              color: AppColors.primary,
            ),
          ),
        if (delete)
          Expanded(
            child: IconButton(
              icon: const Icon(Iconsax.trash),
              onPressed: onDeletePressed,
              color: AppColors.error,
            ),
          ),
      ],
    );
  }
}
