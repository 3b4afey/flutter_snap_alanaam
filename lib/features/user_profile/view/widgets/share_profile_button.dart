import 'package:flutter/material.dart';
import 'package:flutter_snap_alanaam/features/user_profile/user_profile.dart';
import 'package:flutter_snap_alanaam/l10n/l10n.dart';

class ShareProfileButton extends StatelessWidget {
  const ShareProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return UserProfileButton(
      label: context.l10n.loginText,
      onTap: () {},
    );
  }
}
