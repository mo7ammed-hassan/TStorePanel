import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/site_layout.dart';
import 'package:t_store_admin_panel/features/media/cubits/actions/media_action_cubit.dart'
    show MediaActionCubit;
import 'package:t_store_admin_panel/features/media/cubits/media/media_cubit.dart';
import 'package:t_store_admin_panel/features/media/presentation/screens/responsive_screens.dart/media_desktop_screen.dart';

class MediaScreen extends StatelessWidget {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<MediaCubit>()),
        BlocProvider.value(value: getIt<MediaActionCubit>()),
      ],
      child: const SiteTemplate(desktop: MediaDesktopScreen()),
    );  
  }
}
