import 'package:app_ui/app_ui.dart' as AppSpacing;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snap_alanaam/app/view/app.dart';
import 'package:flutter_snap_alanaam/features/authentication/presentation/sign_up.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignupState>(
      listener: (context, state) {
        if (state.submissionStatus.isError) {
          openSnackbar(
              AppSpacing.SnackbarMessage.error(
                title: signupSubmissionStatusMessage[state.submissionStatus]!
                    .title,
                description:
                    signupSubmissionStatusMessage[state.submissionStatus]
                        ?.description,
              ),
              clearIfQueue: true);
        }
      },
      listenWhen: (p, c) => p.submissionStatus != c.submissionStatus,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SignUpEmailFormField(),
          SizedBox(
            height: AppSpacing.md,
          ),
          const SignUpFullNameFormField(),
          SizedBox(
            height: AppSpacing.md,
          ),
          const SignUpUserNameFormField(),
          SizedBox(
            height: AppSpacing.md,
          ),
          const SignUpPasswordFormField(),
        ],
      ),
    );
  }
}
