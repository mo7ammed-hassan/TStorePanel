import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/sidebar_cubit.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/constants/images.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/constants/text_strings.dart';
import 'package:t_store_admin_panel/core/utils/helpers/navigation.dart';
import 'package:t_store_admin_panel/core/utils/popups/full_screen_loader.dart';
import 'package:t_store_admin_panel/core/utils/popups/loaders.dart';
import 'package:t_store_admin_panel/core/utils/validators/validation.dart';
import 'package:t_store_admin_panel/features/authentiacation/presentation/cubit/sign_in/sign_in_cubit.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final signInCubit = context.read<SignInCubit>();
    return Form(
      key: signInCubit.loginKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.spaceBtwSections,
        ),
        child: Column(
          children: [
            // Email
            TextFormField(
              controller: signInCubit.email,
              validator: ValidatorFields.validateEmail,
              decoration: const InputDecoration(
                labelText: TTexts.email,
                prefixIcon: Icon(Iconsax.direct_right),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),

            // Password
            BlocSelector<SignInCubit, SignInState, bool>(
              selector:
                  (state) =>
                      state is TogglePasswordVisibilityState
                          ? state.isPasswordVisible
                          : signInCubit.isPasswordVisible,
              builder: (context, state) {
                return TextFormField(
                  controller: signInCubit.password,
                  validator:
                      (value) =>
                          ValidatorFields.validateEmptyText('Password', value),
                  obscureText: !state,
                  decoration: InputDecoration(
                    labelText: TTexts.password,
                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                      onPressed: () => signInCubit.togglePasswordVisibility(),
                      icon: Icon(state ? Iconsax.eye : Iconsax.eye_slash),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields / 2),

            // Remember Me & Forgot Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Remember Me
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocSelector<SignInCubit, SignInState, bool>(
                      selector:
                          (state) =>
                              state is ToggleCheckBoxVisibilityState
                                  ? state.isCheckBoxVisible
                                  : signInCubit.isCheckBoxVisible,
                      builder: (context, state) {
                        return Checkbox(
                          value: state,
                          onChanged:
                              (value) => signInCubit.toggleCheckBoxVisibility(),
                        );
                      },
                    ),
                    const Text(TTexts.rememberMe),
                  ],
                ),

                // Forgot Password
                TextButton(
                  onPressed: () {
                    context.pushNamedPage(Routes.forgotPassword);
                  },
                  child: const Text(TTexts.forgetPassword),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),

            /// Sign In Button
            BlocListener<SignInCubit, SignInState>(
              listener: (context, state) {
                if (state is SignInLoadingState) {
                  FullScreenLoaderWidget.openLoadingDialog(
                    state.message,
                    AppImages.docerAnimation,
                  );
                }
                if (state is SignInSuccessState) {
                  FullScreenLoaderWidget.stopLoading();
                  context.read<SidebarCubit>().menuOnTap(
                    context,
                    SidebarRoutes.dashboard,
                  );
                  signInCubit.redirect();
                }
                if (state is SignInErrorState) {
                  FullScreenLoaderWidget.stopLoading();
                  Loaders.errorSnackBar(
                    title: 'Oh Snap!',
                    message: state.error,
                  );
                }
              },
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async => await signInCubit.signIn(),
                  child: const Text(TTexts.signIn),
                ),
                // child: ElevatedButton(
                //   onPressed:
                //       () async => await signInCubit.handleRegisterAdmin(),
                //   child: const Text(TTexts.signIn),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
