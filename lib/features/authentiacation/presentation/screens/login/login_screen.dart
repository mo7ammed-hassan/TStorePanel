import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/site_layout.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/features/authentiacation/presentation/cubit/sign_in/sign_in_cubit.dart';
import 'package:t_store_admin_panel/features/authentiacation/presentation/screens/login/responsive_screens/login_desktop_tablet_screen.dart';
import 'package:t_store_admin_panel/features/authentiacation/presentation/screens/login/responsive_screens/login_mobile_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final signInCubit = getIt<SignInCubit>();
    return BlocProvider(
      create: (context) => signInCubit..getStorageEmailAndPassword(),
      child: SiteTemplate(
        backgroundColor: isDark ? Colors.black : Colors.white,
        useLayout: false,
        desktop: const LoginDesktopTabletScreen(),
        mobile: const LoginMobileScreen(),
      ),
    );
  }
}
