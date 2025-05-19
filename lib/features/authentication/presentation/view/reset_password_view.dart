import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snap_alanaam/features/authentication/presentation/forgot_password.dart';
import 'package:flutter_snap_alanaam/l10n/l10n.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  void _confirmGoBack(BuildContext context) => context.confirmAction(
        fn: () => context
            .read<ManagePasswordCubit>()
            .changeScreen(showForgotPassword: true),
        title: context.l10n.loginText,
        content: context.l10n.loginText,
        noText: context.l10n.loginText,
        yesText: context.l10n.loginText,
        yesTextStyle: context.labelLarge?.apply(color: AppColors.blue),
      );

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        onPopInvokedWithResult: (didPop, p1) {
          if (didPop) return;
          _confirmGoBack(context);
        },
        releaseFocus: true,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(context.l10n.loginText),
          centerTitle: false,
          leading: IconButton(
              onPressed: () => _confirmGoBack(context),
              icon: Icon(Icons.adaptive.arrow_back)),
        ),
        body: AppConstrainedScrollView(
            padding: EdgeInsets.symmetric(horizontal: xl),
            child: Column(
              children: [
                Gap.v(xxl * 3),
                Expanded(
                    child: Column(
                  children: [
                    ChangePasswordForm(),
                    Gap.v(md),
                    ChangePasswordButton()
                  ],
                ))
              ],
            )));
  }
}
