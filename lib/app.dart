import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/config/routes/app_router.dart';
import 'package:t_store_admin_panel/config/routes/route_observer.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/app_context.dart';
import 'package:t_store_admin_panel/core/utils/utils/theme/theme.dart';
import 'package:t_store_admin_panel/data/services/authentication/authentaication_local_data_source.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [CustomRouteObserver()],
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      navigatorKey: AppContext.navigatorKey,
      initialRoute: loggedIn ? Routes.dashboard : Routes.login,
      onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
    );
  }
}
