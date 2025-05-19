// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared/shared.dart';

/// Navigation bar items
List<GButton> mainNavigationBarItems() => [
      const GButton(
        icon: Icons.home_rounded,
      ),
      const GButton(
        icon: Icons.chat,
      ),
      const GButton(
        icon: Icons.add_box_outlined,
      ),
      const GButton(
        icon: Icons.notifications,
      ),
      const GButton(
        icon: LineIcons.user,
      ),
    ];

// class NavBarItem {
// NavBarItem({
// this.icon,
// this.label,
// this.child,
// });
//
// final String? label;
// final Widget? child;
// final IconData? icon;
//
// String? get tooltip => label;
// }

class GradientColor {
  const GradientColor({required this.hex, this.opacity});

  final String hex;
  final double? opacity;
}

enum PremiumGradient {
  fl0(
    colors: [
      GradientColor(hex: '842CD7'),
      GradientColor(hex: '21F5F1', opacity: .8),
    ],
    stops: [0, 1],
  ),
  telegram(
    colors: [
      GradientColor(hex: '6C93FF'),
      GradientColor(hex: '976FFF'),
      GradientColor(hex: 'DF69D1'),
    ],
    stops: [0, .5, 1],
  );

  const PremiumGradient({
    required this.colors,
    required this.stops,
  });

  final List<GradientColor> colors;
  final List<double> stops;
}

List<String> get commentEmojies =>
    ['🩷', '🙌', '🔥', '👏🏻', '😢', '😍', '😮', '😂'];

List<ModalOption> createMediaModalOptions({
  required String reelLabel,
  // required String postLabel,
  required String storyLabel,
  required BuildContext context,
  required void Function(String route, {Object? extra}) goTo,
  required bool enableStory,
  ValueSetter<String>? onStoryCreated,
}) =>
    <ModalOption>[
      ModalOption(
        name: reelLabel,
        iconData: Icons.video_collection_outlined,
        onTap: () => goTo('create-post', extra: true),
      ),
      // ModalOption(
      //   name: postLabel,
      //   iconData: Icons.outbox_outlined,
      //   onTap: () => goTo('create-post'),
      // ),
      if (enableStory)
        ModalOption(
          name: storyLabel,
          iconData: Icons.cameraswitch_outlined,
          onTap: () => goTo('create-stories', extra: onStoryCreated),
        ),
    ];

List<ModalOption> followerModalOptions({
  required String unfollowLabel,
  required VoidCallback onUnfollowTap,
}) =>
    <ModalOption>[ModalOption(name: unfollowLabel, onTap: onUnfollowTap)];
