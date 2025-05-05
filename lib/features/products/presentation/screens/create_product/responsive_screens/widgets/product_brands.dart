import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/constants/images.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:t_store_admin_panel/data/models/brands/brand_model.dart';

class ProductBrands extends StatelessWidget {
  const ProductBrands({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Brand', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: AppSizes.spaceBtwItems),

          // form to add new brand
          TypeAheadField(
            builder: (context, ctr, focusNode) {
              return TextFormField(
                focusNode: focusNode,
                decoration: const InputDecoration(
                  labelText: 'Select Brand',
                  suffixIcon: Icon(Iconsax.box),
                  border: OutlineInputBorder(),
                ),
              );
            },
            onSelected: (suggestion) {},
            suggestionsCallback: (String search) {
              return [
                BrandModel(
                  id: '1',
                  image: AppImages.adidasLogo,
                  name: 'Adidas',
                ),
                BrandModel(id: '2', image: AppImages.nikeLogo, name: 'Nike'),
                BrandModel(id: '3', image: AppImages.pumaLogo, name: 'Puma'),
              ];
            },
            itemBuilder: (BuildContext context, suggestion) {
              return ListTile(title: Text(suggestion.name));
            },
          ),
        ],
      ),
    );
  }
}
