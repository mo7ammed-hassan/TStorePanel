import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/features/products/cubits/cubit/product_cubit.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/all_products/responsive_screens/product_desktop_screen.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/all_products/responsive_screens/product_mobile_screen.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/all_products/responsive_screens/product_tablet_screen.dart';
import 'package:t_store_admin_panel/layouts/responsive_screens.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProductCubit>(),
      child: const ResponsiveScreens(
        desktop: ProductDesktopScreen(),
        tablet: ProductTabletScreen(),
        mobile: ProductMobileScreen(),
      ),
    );
  }
}
