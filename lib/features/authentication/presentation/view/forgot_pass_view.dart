import 'package:app_ui/app_ui.dart' as App;
import 'package:flutter/material.dart';
import 'package:flutter_snap_alanaam/features/authentication/presentation/forgot_password.dart';
import 'package:flutter_snap_alanaam/l10n/l10n.dart';

class ForgotPassView extends StatelessWidget {
  const ForgotPassView({super.key});

  @override
  Widget build(BuildContext context) {
    return App.AppScaffold(
        releaseFocus: true,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(context.l10n.forgotPasswordText),
          centerTitle: false,
        ),
        body: App.AppConstrainedScrollView(
            padding: EdgeInsets.symmetric(horizontal: App.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                App.Gap.v(App.xxl * 3),
                ForgotPasswordEmailConfirmationLabel(),
                App.Gap.v(App.md),
                ForgotPasswordForm(),
                App.Gap.v(App.md),
                ForgotButtonSendEmailButton()
              ],
            )));
  }
}

class ForgotPasswordEmailConfirmationLabel extends StatelessWidget {
  const ForgotPasswordEmailConfirmationLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      context.l10n.loginText,
      style: context.headlineSmall,
    );
  }
}
