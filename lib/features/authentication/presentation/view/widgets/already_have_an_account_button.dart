import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snap_alanaam/features/authentication/presentation/auth.dart';
import 'package:flutter_snap_alanaam/l10n/l10n.dart';

/// {@template sign_in_into_account_button}
/// Sign up widget that contains sign up button.
/// {@endtemplate}
class AlreadyHaveAnAccountButton extends StatelessWidget {
  /// {@macro sign_in_into_account_button}
  const AlreadyHaveAnAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Tappable.faded(
          onTap: () => cubit.changeAuth(showLogin: true),
          child: RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${context.l10n.alreadyHaveAccountText} ',
                  style: context.bodyMedium,
                ),
                TextSpan(
                  text: '${context.l10n.loginText}.',
                  style:
                      context.bodyMedium?.apply(color: AppColors.kPrimaryColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
