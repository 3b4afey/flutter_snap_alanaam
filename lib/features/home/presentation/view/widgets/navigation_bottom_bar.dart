import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snap_alanaam/features/feed/post/video/widgets/video_player_inherited_widget.dart';
import 'package:flutter_snap_alanaam/features/home/presentation/home.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavigationBottomBar extends StatelessWidget {
  const NavigationBottomBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final navigationBarItems = mainNavigationBarItems();
    final videoPlayer = VideoPlayerInheritedWidget.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      decoration: BoxDecoration(
          color: Color(0xff252525).withAlpha(220),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: AppColors.kPrimaryColor.withAlpha(100), width: 1)),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            tabBackgroundGradient: LinearGradient(colors: [
              Color(0xffFFD700).withAlpha(100),
              Color(0xffBCA006).withAlpha(50)
            ]),
            tabBorderRadius: 10,
            rippleColor: Theme.of(context).canvasColor,
            hoverColor: Colors.grey.withAlpha(10)!,
            gap: 8,
            activeColor: Theme.of(context).hintColor,
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: Duration(milliseconds: 400),
            color: Theme.of(context).canvasColor.withAlpha(100),
            tabs: navigationBarItems,
            selectedIndex: navigationShell.currentIndex,
            onTabChange: (index) {
              HomeProvider().togglePageView(enable: index == 0);
              if ([0, 1, 2, 3].contains(index)) {
                // if (index case 0) videoPlayer.videoPlayerState.playFeed();
                if (index case 1) videoPlayer.videoPlayerState.playTimeline();
                if (index case 2) {
                  HomeProvider().animateToPage(0);
                  HomeProvider().togglePageView();
                }
                if (index case 0) videoPlayer.videoPlayerState.playReels();
              } else {
                videoPlayer.videoPlayerState.stopAll();
              }
              if (index != 2) {
                navigationShell.goBranch(
                  index,
                  initialLocation: index == navigationShell.currentIndex,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
