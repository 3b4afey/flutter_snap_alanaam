import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class UserProfileActions extends StatelessWidget {
  const UserProfileActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Tappable.faded(
      onTap: () {},
      child: Icon(Icons.more_vert, size: AppSize.iconSize),
    );
  }
}
