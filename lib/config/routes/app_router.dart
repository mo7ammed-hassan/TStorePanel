import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/features/authentiacation/presentation/screens/forgot_password/forgot_password_screen.dart';
import 'package:t_store_admin_panel/features/authentiacation/presentation/screens/login/login_screen.dart';
import 'package:t_store_admin_panel/features/authentiacation/presentation/screens/reset_password/reset_password_screen.dart';
import 'package:t_store_admin_panel/features/banners/presentation/screens/all_banners/banner_screen.dart';
import 'package:t_store_admin_panel/features/banners/presentation/screens/create_banners/create_banner_screen.dart';
import 'package:t_store_admin_panel/features/banners/presentation/screens/edit_banners/edit_banner_screen.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/all_brands/brand_screen.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/create_brands/create_brand_screen.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/edit_brands/edit_brand_screen.dart';
import 'package:t_store_admin_panel/features/categories/presentation/screens/all_categories/category_screen.dart';
import 'package:t_store_admin_panel/features/categories/presentation/screens/create_category/create_category_screen.dart';
import 'package:t_store_admin_panel/features/categories/presentation/screens/edit_category/edit_category_screen.dart';
import 'package:t_store_admin_panel/features/customers/presentation/screens/all_customers/customers_screen.dart';
import 'package:t_store_admin_panel/features/customers/presentation/screens/customer_detail/customer_details_screen.dart';
import 'package:t_store_admin_panel/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:t_store_admin_panel/features/media/presentation/screens/media_screen.dart';
import 'package:t_store_admin_panel/features/order/screens/all_orders/orders_screen.dart';
import 'package:t_store_admin_panel/features/order/screens/order_detail/order_details_screen.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/all_products/product_screen.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/create_product/create_product_screen.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/edit_product/edit_product_screen.dart';
import 'package:t_store_admin_panel/test_screen.dart';

class AppRouter {
  static final Map<String, Widget Function(BuildContext)> _routes = {
    // Main Screen
    Routes.dashboard: (_) => const DashboardScreen(),

    // --Authentication
    // Login
    Routes.login: (_) => const LoginScreen(),
    // Forgot Password
    Routes.forgotPassword: (_) => const ForgotPasswordScreen(),
    // Reset Password
    Routes.resetPassword: (_) => const ResetPasswordScreen(),

    // --Side Bar Menu
    // Media
    Routes.media: (_) => const MediaScreen(),

    // Categories
    Routes.categories: (_) => const CategoryScreen(),
    Routes.editCategory: (_) => const EditCategoryScreen(),
    Routes.createCategory: (_) => const CreateCategoryScreen(),
    // Products
    Routes.products: (_) => const ProductScreen(),
    Routes.createProduct: (_) => const CreateProductScreen(),
    Routes.editProduct: (_) => const EditProductScreen(),

    // Banners
    Routes.banners: (_) => const BannerScreen(),
    Routes.editBanner: (_) => const EditBannerScreen(),
    Routes.createBanner: (_) => const CreateBannerScreen(),

    // Brands
    Routes.brands: (_) => const BrandScreen(),
    Routes.editBrand: (_) => const EditBrandScreen(),
    Routes.createBrand: (_) => const CreateBrandScreen(),

    // Customers
    Routes.customers: (_) => const CustomersScreen(),
    Routes.customerDetails: (_) => const CustomerDetailScreen(),

    // Orders
    Routes.orders: (_) => const OrdersScreen(),
    Routes.orderDetail: (_) => const OrderDetailsScreen(),

    Routes.testScreen: (_) => const TestScreen(),
  };

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final Uri uri = Uri.parse(settings.name ?? '');
    final path =
        (uri.pathSegments.length > 1) ? '/${uri.pathSegments[0]}' : uri.path;

    final pageBuilder = _routes[path];

    // if (pageBuilder != null) {
    //   return RouteMiddleware.protectRoute(settings, pageBuilder);
    // }
    if (pageBuilder != null) {
      return MaterialPageRoute(builder: pageBuilder, settings: settings);
    }
    return null;
  }
}

//  final String path = uri.path;
//  final String query = uri.query;
//  final Map<String, String> queryParams =
//  uri.queryParameters; // {email: some@gmail.com}
// print('Path: $path');
// print('Query: $query'); // هتكون 'users'
// print('Query Parameters: $queryParams'); // {email: some@gmail.com}
// print('Path Segments: ${uri.pathSegments}'); //  [reset-password, users]
// print(
//   'pathOfReset: ${(uri.pathSegments.length > 1) ? uri.pathSegments[0] : ''}',
// ); //  [reset-password, users]
// print(
//   'ActulyPath: ${(uri.pathSegments.length > 1) ? '/${uri.pathSegments[0]}' : ''}',
// );
