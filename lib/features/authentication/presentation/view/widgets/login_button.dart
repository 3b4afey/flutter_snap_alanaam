import 'package:app_ui/app_ui.dart' as App;
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snap_alanaam/features/authentication/presentation/login.dart';
import 'package:flutter_snap_alanaam/l10n/l10n.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    final style = ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(AppColors.kPrimaryColor),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(App.defaultBorderRadius)),
      ),
    );
    final isLoading =
        context.select((LoginCubit bloc) => bloc.state.status.isLoading);
    final child = switch (isLoading) {
      true => App.AppButton.inProgress(style: style, scale: 0.5),
      _ => App.AppButton.auth(
          context.l10n.loginText,
          () => context.read<LoginCubit>().onSubmit(),
          style: style,
          outlined: true,
        ),
    };
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: switch (context.screenWidth) {
            > 600 => context.screenWidth * .6,
            _ => context.screenWidth * 0.4,
          },
        ),
        child: child,
      ),
    );
  }
}
