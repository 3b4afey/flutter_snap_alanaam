import 'package:app_ui/app_ui.dart' as App;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snap_alanaam/features/authentication/presentation/forgot_password.dart';
import 'package:flutter_snap_alanaam/l10n/l10n.dart';
import 'package:shared/shared.dart';

class ForgotButtonSendEmailButton extends StatelessWidget {
  const ForgotButtonSendEmailButton({super.key});

  void _onPressed(BuildContext context) =>
      context.read<ForgotPasswordCubit>().onSubmit(
            onSuccess: () => context
                .read<ManagePasswordCubit>()
                .changeScreen(showForgotPassword: false),
          );

  @override
  Widget build(BuildContext context) {
    final isLoading = context
        .select((ForgotPasswordCubit bloc) => bloc.state.status.isLoading);
    final child = App.Tappable.faded(
      throttle: true,
      throttleDuration: 650.ms,
      backgroundColor: App.AppColors.kPrimaryColor,
      borderRadius: BorderRadius.circular(App.defaultBorderRadius),
      onTap: isLoading ? null : () => _onPressed(context),
      child: isLoading
          ? Center(child: App.AppCircularProgress(context.adaptiveColor))
          : Padding(
              padding: EdgeInsets.symmetric(
                vertical: App.s * 1.2,
              ),
              child: Align(
                child: Text(
                  context.l10n.loginText,
                  style: context.labelLarge?.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
    );
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: switch (context.screenWidth) {
          > 600 => context.screenWidth * .6,
          _ => context.screenWidth,
        },
      ),
      child: child,
    );
  }
}
