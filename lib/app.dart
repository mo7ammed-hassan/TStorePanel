import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/config/routes/app_router.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/utils/helpers/app_context.dart';
import 'package:t_store_admin_panel/core/utils/theme/theme.dart';
import 'package:t_store_admin_panel/data/services/authentication/authentication_firebase_services.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // navigatorObservers: [
          //   //CustomRouteObserver(context.read<SidebarCubit>()),
          // ],
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          navigatorKey: AppContext.navigatorKey,
          initialRoute:
              getIt<AuthFirebaseServices>().alreadyLoggedIn()
                  ? Routes.adminLayout
                  : Routes.login,
          onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
        );
      },
    );
  }
}
