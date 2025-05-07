import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/features/authentiacation/presentation/screens/login/login_screen.dart';
import 'package:t_store_admin_panel/features/banners/presentation/screens/all_banners/banner_screen.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/all_brands/brand_screen.dart';
import 'package:t_store_admin_panel/features/categories/presentation/screens/all_categories/category_screen.dart';
import 'package:t_store_admin_panel/features/customers/presentation/screens/all_customers/customers_screen.dart';
import 'package:t_store_admin_panel/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:t_store_admin_panel/features/media/presentation/screens/media_screen.dart';
import 'package:t_store_admin_panel/features/order/screens/all_orders/orders_screen.dart';
import 'package:t_store_admin_panel/features/personalization/presentation/screens/profile/profile_screen.dart';
import 'package:t_store_admin_panel/features/personalization/presentation/screens/settings/settings_screen.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/all_products/product_screen.dart';

extension SidebarRouteExtension on SidebarRoutes {
  String get path {
    switch (this) {
      case SidebarRoutes.dashboard:
        return Routes.dashboard;
      case SidebarRoutes.media:
        return Routes.media;
      case SidebarRoutes.categories:
        return Routes.categories;
      case SidebarRoutes.brands:
        return Routes.brands;
      case SidebarRoutes.products:
        return Routes.products;
      case SidebarRoutes.banners:
        return Routes.banners;
      case SidebarRoutes.orders:
        return Routes.orders;
      case SidebarRoutes.settings:
        return Routes.settings;
      case SidebarRoutes.profile:
        return Routes.profile;
      case SidebarRoutes.customers:
        return Routes.customers;
      case SidebarRoutes.login:
        return Routes.login;
    }
  }
}

// extension to return screen depend on route that passed from sidebar
extension SidebarScreenExtension on SidebarRoutes {
  Widget get screen {
    switch (this) {
      case SidebarRoutes.dashboard:
        return const DashboardScreen();
      case SidebarRoutes.media:
        return const MediaScreen();
      case SidebarRoutes.categories:
        return const CategoryScreen();
      case SidebarRoutes.brands:
        return const BrandScreen();
      case SidebarRoutes.products:
        return const ProductScreen();
      case SidebarRoutes.banners:
        return const BannerScreen();
      case SidebarRoutes.orders:
        return const OrdersScreen();
      case SidebarRoutes.settings:
        return const SettingsScreen();
      case SidebarRoutes.profile:
        return const ProfileScreen();
      case SidebarRoutes.customers:
        return const CustomersScreen();
      case SidebarRoutes.login:
        return const LoginScreen();
    }
  }
}
