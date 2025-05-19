import 'package:app_ui/app_ui.dart' as AppSpacing;
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snap_alanaam/features/authentication/presentation/login.dart';
import 'package:flutter_snap_alanaam/features/authentication/presentation/view/widgets/login_button.dart';
import 'package:flutter_snap_alanaam/l10n/l10n.dart';
import 'package:user_repository/user_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      releaseFocus: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: AppConstrainedScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    AppLogo(
                      fit: BoxFit.fill,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: AppSpacing.xxl * 2,
                    ),
                    Text(
                      context.l10n.loginText,
                      style: context.titleLarge,
                    ),
                    SizedBox(
                      height: AppSpacing.xl,
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  const LoginForm(),
                  const SizedBox(
                    height: 6,
                  ),
                  const Align(
                    alignment: Alignment.bottomRight,
                    child: ForgotPasswordButton(),
                  ),
                  SizedBox(
                    height: AppSpacing.md,
                  ),
                  Align(
                    child: SignInButton(),
                  ),
                  SizedBox(
                    height: AppSpacing.md,
                  ),
                  AppDivider(
                    color: AppColors.white,
                    height: 2,
                    text: 'Or continue with',
                  ),
                  SizedBox(
                    height: AppSpacing.l,
                  ),
                  // Spacer(),
                  Row(
                    children: [
                      Expanded(
                          child: AuthProviderSignInButton(
                              provider: AuthProvider.facebook,
                              onPressed: () {
                                context.read<UserRepository>().logOut();
                              })),
                      SizedBox(
                        width: AppSpacing.md,
                      ),
                      Expanded(
                          child: AuthProviderSignInButton(
                              provider: AuthProvider.google,
                              onPressed: () {
                                context.read<LoginCubit>().loginWithGoogle();
                              })),
                    ],
                  ),
                ],
              ),
            ),
            Align(
                alignment: Alignment.center, child: AlreadyHaveAccountButton()),
          ],
        ),
      ),
    );
  }
}
