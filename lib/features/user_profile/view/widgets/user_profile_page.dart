import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snap_alanaam/app/app.dart';
import 'package:flutter_snap_alanaam/features/user_profile/user_profile.dart';
import 'package:sliver_tools/sliver_tools.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key, required this.userId, required this.props});

  @override
  bool get wantKeepAlive => true;
  final UserProfileProps props;
  final String userId;

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
    with SingleTickerProviderStateMixin {
  late ScrollController _nestedScrollController;
  UserProfileProps get props => widget.props;

  @override
  void initState() {
    _nestedScrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _nestedScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    final isOwner = context.select((UserProfileBloc bloc) => bloc.isOwner);
    return AppScaffold(
        body: DefaultTabController(
            length: 2,
            child: NestedScrollView(
                controller: _nestedScrollController,
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      sliver: MultiSliver(
                        children: [
                          UserSliverAppBar(
                            fullName:
                                isOwner ? user.displayFullName : widget.userId,
                          ),
                          if (!user.isAnonymous) ...[
                            UserProfileHeader(
                              userId: user.id,
                            ),
                            SliverPersistentHeader(
                                pinned: !ModalRoute.of(context)!.isFirst,
                                delegate: _SliverAppBarDelegate(TabBar(
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  padding: EdgeInsets.zero,
                                  labelPadding: EdgeInsets.zero,
                                  indicatorWeight: 1,
                                  tabs: [
                                    Tab(
                                      icon: Icon(Icons.grid_view_rounded),
                                      iconMargin: EdgeInsets.zero,
                                    ),
                                    Tab(
                                      icon: Icon(Icons.favorite_border),
                                      iconMargin: EdgeInsets.zero,
                                    )
                                  ],
                                ))),
                          ]
                        ],
                      ),
                    )
                  ];
                },
                body: TabBarView(
                  children: [
                    PostsPage(sponsoredPost: props.sponsoredPost,),
                    UserProfileMentionedPostsPage(),
                  ],
                ))));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ColoredBox(
      color: context.theme.scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}
