import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snap_alanaam/features/authentication/presentation/forgot_password.dart';
import 'package:flutter_snap_alanaam/l10n/l10n.dart';
import 'package:shared/shared.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Tappable.faded(
      throttle: true,
      throttleDuration: 650.ms,
      onTap: () {
        Navigator.pushAndRemoveUntil(
          context,
          MnageForgotPasswordPage.route(),
          (_) => true,
        );
      },
      child: Text(
        context.l10n.forgotPasswordText,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.titleSmall?.copyWith(color: AppColors.kPrimaryColor),
      ),
    );
  }
}
