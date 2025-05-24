import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snap_alanaam/features/chats/chats.dart';
import 'package:flutter_snap_alanaam/features/feed/post/video/widgets/video_player_inherited_widget.dart';
import 'package:flutter_snap_alanaam/features/home/presentation/home.dart';
import 'package:flutter_snap_alanaam/features/user_profile/view/widgets/user_profile_create_post.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late PageController _pageController;
  late VideoPlayerState _videoPlayerState;

  @override
  void initState() {
    _pageController = PageController(initialPage: 1);
    super.initState();
    _videoPlayerState = VideoPlayerState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      HomeProvider().setPageController(_pageController);
    });
  }

  void _onPageScroll() {
    _pageController.position.isScrollingNotifier.addListener(_isPageScrolling);
  }

  void _isPageScrolling() {
    final isScrolling =
        _pageController.position.isScrollingNotifier.value == true;
    final mainPageView = _pageController.page == 1;
    final navigationBarIndex = widget.navigationShell.currentIndex;
    final isReels = !isScrolling && mainPageView && navigationBarIndex == 0;
    final isTimeline = !isScrolling && mainPageView && navigationBarIndex == 1;
    final isFeed = !isScrolling && mainPageView && navigationBarIndex == 3;

    if (isScrolling) {
      _videoPlayerState.stopAll();
    }
    switch ((isFeed, isTimeline, isReels)) {
      case (true, false, false):
        _videoPlayerState.playFeed();
      case (false, true, false):
        _videoPlayerState.playTimeline();
      case (false, false, true):
        _videoPlayerState.playFeed();
      case _:
        _videoPlayerState.stopAll();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.navigationShell.currentIndex == 0 &&
        !HomeProvider().enablePageView) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        HomeProvider().togglePageView();
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return AppScaffold(
    //   body: widget.navigationShell,
    //   // bottomNavigationBar:
    //  floatingActionButton: Row(
    //
    //    children: [
    //      NavigationBottomBar(
    //        navigationShell: widget.navigationShell,
    //      ),
    //    ],
    //  ),
    //   floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
    // );

    return VideoPlayerInheritedWidget(
      videoPlayerState: _videoPlayerState,
      child: ListenableBuilder(
        listenable: HomeProvider(),
        builder: (context, child) {
          return PageView.builder(
            itemCount: 3,
            controller: _pageController,
            physics: HomeProvider().enablePageView
                ? null
                : const NeverScrollableScrollPhysics(),
            onPageChanged: (page) {
              if (page != 0 && page != 2 && page == 1) {
                customImagePickerKey.currentState?.resetAll();
              }
              if (page == 1 && widget.navigationShell.currentIndex != 0) {
                HomeProvider().togglePageView(enable: false);
              }
            },
            itemBuilder: (context, index) {
              return switch (index) {
                0 => UserProfileCreatePost(
                    canPop: false,
                    pickVideo: true,
                    imagePickerKey: customImagePickerKey,
                    onPopInvoked: () => HomeProvider().animateToPage(1),
                    onBackButtonTap: () => HomeProvider().animateToPage(1),
                  ),
                2 => const ChatsPage(),
                _ => AppScaffold(
                    body: widget.navigationShell,
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.miniStartFloat,
                    floatingActionButton: Row(
                      children: [
                        NavigationBottomBar(
                          navigationShell: widget.navigationShell,
                        ),
                      ],
                    ),
                  ),
              };
            },
          );
        },
      ),
    );
  }
}
