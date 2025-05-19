import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snap_alanaam/features/user_profile/user_profile.dart';
import 'package:flutter_snap_alanaam/selector/selector.dart';
import 'package:shared/shared.dart';

class UserProfileSettingsButton extends StatelessWidget {
  const UserProfileSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Tappable.faded(
      onTap: () => context.showListOptionsModal(
        options: [
          ModalOption(child: const LocaleModalOption()),
          ModalOption(child: const ThemeSelectorModalOption()),
          ModalOption(child: const LogoutModalOption()),
        ],
      ).then((option) {
        if (option == null) return;
        void onTap() => option.onTap(context);
        onTap.call();
      }),
      child: Icon(
        Icons.menu,
        size: AppSize.iconSize,
        color: context.adaptiveColor,
      ),
    );
  }
}
