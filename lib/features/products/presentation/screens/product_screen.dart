import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/site_layout.dart';
import 'package:t_store_admin_panel/features/products/cubits/cubit/product_cubit.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/responsive_screens/product_desktop_screen.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(),
      child: const SiteTemplate(
        desktop: ProductDesktopScreen(),
        // tablet: ProductTabletScreen(),
        // mobile: ProductMobileScreen(),
      ),
    );
  }
}
