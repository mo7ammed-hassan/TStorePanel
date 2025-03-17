class Routes {
  // Auth Routes
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  // Sidebar Routes
  static const String categories = '/categories';
  static const String products = '/products';
  static const String banners = '/banners';
  static const String media = '/media';

  static const String dashboard = '/dashboard';

  // sidebarMenuRoutes
  static List<String> get sidebarMenuRoutes => [
    dashboard,
    media,
    categories,
    products,
    banners,
  ];

  // Test Screen
  static const String testScreen = '/test-screen';
}
