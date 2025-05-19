import 'package:flutter/material.dart';
import 'package:flutter_snap_alanaam/app/app.dart';
import 'package:flutter_snap_alanaam/features/user_profile/user_profile.dart';
import 'package:flutter_snap_alanaam/l10n/l10n.dart';
import 'package:go_router/go_router.dart';

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return UserProfileButton(
      label: context.l10n.loginText,
      onTap: () => context.pushNamed(AppRoutes.editProfile.name),
    );
  }
}
