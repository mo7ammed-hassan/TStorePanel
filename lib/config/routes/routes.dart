class Routes {
  // Admin Layout
  static const String adminLayout = '/admin-layout';

  // Auth Routes
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  // Sidebar Routes
  static const String categories = '/categories';
  static const String editCategory = '/edit-category';
  static var createCategory = '/create-category';

  static const String products = '/products';
  static const String createProduct = '/create-product';
  static const String editProduct = '/edit-product';

  static const String banners = '/banners';
  static const String createBanner = '/create-banner';
  static const String editBanner = '/edit-banner';

  static const String media = '/media';

  static const String brands = '/brands';
  static const String createBrand = '/create-brand';
  static const String editBrand = '/edit-brand';

  static const String dashboard = '/dashboard';

  static const String customers = '/customers';
  static const String customerDetails = '/customer-details';

  static const String orders = '/orders';
  static const String orderDetail = '/order-detail';

  static const String settings = '/settings';
  static const String profile = '/profile';

  // sidebarMenuRoutes
  static List<String> get sidebarMenuRoutes => [
    dashboard,
    media,
    categories,
    brands,
    products,
    banners,
    orders,
    settings,
    profile,
    customers,
    login,
  ];
  // Test Screen
  static const String testScreen = '/test-screen';
}
