import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart'
    show MultiSelectItem;
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Categories', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: AppSizes.spaceBtwItems),

          MultiSelectDialogField(
            buttonText: const Text('Select Categories'),
            title: const Text('Categories'),
            items: [
              MultiSelectItem(
                CategoryModel(id: 'id', name: 'Shoes', image: 'image'),
                'Shoes',
              ),
              MultiSelectItem(
                CategoryModel(id: 'id', name: 'Shirts', image: 'image'),
                'Shirts',
              ),
            ],
            listType: MultiSelectListType.CHIP,
            onConfirm: (value) {},
          ),
        ],
      ),
    );
  }
}
