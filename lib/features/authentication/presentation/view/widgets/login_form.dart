import 'package:app_ui/app_ui.dart' as AppSpacing;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snap_alanaam/app/view/app.dart';
import 'package:flutter_snap_alanaam/features/authentication/presentation/login.dart';
import 'package:flutter_snap_alanaam/l10n/l10n.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isError) {
          openSnackbar(
              AppSpacing.SnackbarMessage.error(
                  title: loginSubmissionStatusMessage[state.status]?.title ??
                      state.message ??
                      context.l10n.loginText,
                  description:
                      loginSubmissionStatusMessage[state.status]?.description),
              clearIfQueue: true);
        }
      },
      listenWhen: (previous, current) => previous.status != current.status,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const EmailFormField(),
          SizedBox(
            height: AppSpacing.md,
          ),
          const PasswordFormField(),
        ],
      ),
    );
  }
}
