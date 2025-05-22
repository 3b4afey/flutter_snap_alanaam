import 'dart:math';

import 'package:app_ui/app_ui.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snap_alanaam/features/feed/post/post.dart';
import 'package:flutter_snap_alanaam/features/user_profile/user_profile.dart';
import 'package:flutter_snap_alanaam/l10n/l10n.dart';
import 'package:snap_blocks/snap_blocks.dart';
import 'package:snap_alanaam_blocks_ui/snap_alanaam_blocks_ui.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared/shared.dart';

class UserProfilePosts extends StatefulWidget {
  const UserProfilePosts({
    required this.userId,
    required this.index,
    super.key,
  });

  final String userId;
  final int index;

  @override
  State<UserProfilePosts> createState() => _UserProfilePostsState();
}

class _UserProfilePostsState extends State<UserProfilePosts> {
  late ItemScrollController _itemScrollController;
  late ItemPositionsListener _itemPositionsListener;
  late ScrollOffsetController _scrollOffsetController;
  late ScrollOffsetListener _scrollOffsetListener;

  @override
  void initState() {
    super.initState();
    _itemScrollController = ItemScrollController();
    _itemPositionsListener = ItemPositionsListener.create();
    _scrollOffsetController = ScrollOffsetController();
    _scrollOffsetListener = ScrollOffsetListener.create();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: InViewNotifierCustomScrollView(
        cacheExtent: 2760,
        initialInViewIds: [widget.index.toString()],
        isInViewPortCondition: (deltaTop, deltaBottom, vpHeight) {
          return deltaTop < (0.5 * vpHeight) + 80.0 &&
              deltaBottom > (0.5 * vpHeight) - 80.0;
        },
        slivers: [
          UserProfilePostsAppBar(userId: widget.userId),
          StreamBuilder<List<PostBlock>>(
            stream: context.read<UserProfileBloc>().userPosts(small: false),
            builder: (context, snapshot) {
              final blocks = snapshot.data;

              return PostsListView(
                postBuilder: (_, index, block) => PostView(
                  key: ValueKey(block.id),
                  block: block,
                  postIndex: index,
                  withCustomVideoPlayer: false,
                ),
                withItemController: true,
                blocks: blocks,
                withLoading: false,
                itemScrollController: _itemScrollController,
                itemPositionsListener: _itemPositionsListener,
                scrollOffsetController: _scrollOffsetController,
                scrollOffsetListener: _scrollOffsetListener,
                index: widget.index,
              );
            },
          ),
        ],
      ),
    );
  }
}

class UserProfilePostsAppBar extends StatelessWidget {
  const UserProfilePostsAppBar({required this.userId, super.key});

  final String userId;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserProfileBloc>();
    final isOwner = context.select((UserProfileBloc b) => b.isOwner);

    late final followText = Padding(
      padding: EdgeInsets.only(right: l),
      child: Tappable.faded(
        onTap: () => bloc.add(const UserProfileFollowUserRequested()),
        child: Text(
          context.l10n.followUser,
          style: context.titleLarge?.copyWith(
            color: AppColors.blue,
          ),
        ),
      ),
    );

    return SliverAppBar(
      centerTitle: false,
      pinned: true,
      actions: [
        BetterStreamBuilder<bool>(
          stream: bloc.followingStatus(),
          builder: (context, isFollowed) {
            if (isFollowed || isOwner) return const SizedBox.shrink();

            return AnimatedSwitcher(
              switchInCurve: Curves.easeIn,
              duration: 550.ms,
              child: isFollowed ? const SizedBox.shrink() : followText,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: CurvedAnimation(
                    parent: animation,
                    curve: const Interval(0.3, 1),
                  ),
                  child: child,
                );
              },
            );
          },
        ),
      ],
      title: Text(
        context.l10n.profilePostsAppBarTitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

/////////////////////////////

class PostsPage extends StatefulWidget {
  const PostsPage({this.sponsoredPost, super.key});

  final PostSponsoredBlock? sponsoredPost;

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserProfileBloc>();

    super.build(context);
    return CustomScrollView(
      cacheExtent: 2760,
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        BetterStreamBuilder<List<PostBlock>>(
          initialData: const <PostBlock>[],
          stream: bloc.userPosts(),
          comparator: const ListEquality<PostBlock>().equals,
          builder: (context, blocks) {
            if (blocks.isEmpty && widget.sponsoredPost == null) {
              return const EmptyPosts();
            }
            return SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
              ),
              itemCount: widget.sponsoredPost != null ? 1 : blocks.length,
              itemBuilder: (context, index) {
                final block = widget.sponsoredPost ?? blocks[index];
                final multiMedia = block.media.length > 1;

                return PostPopup(
                  block: block,
                  index: index,
                  builder: (_) => PostSmall(
                    key: ValueKey(block.id),
                    pinned: false,
                    isReel: block.isReel,
                    multiMedia: multiMedia,
                    mediaUrl: block.firstMediaUrl!,
                    imageThumbnailBuilder: (_, url) => PostSmallImage(url: url),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class PostSmallImage extends StatelessWidget {
  const PostSmallImage({required this.url, super.key});

  final String url;

  @override
  Widget build(BuildContext context) {
    /// AppSpacing.xxs is the padding of the image.
    final screenWidth = (context.screenWidth - 2) / 3;
    final pixelRatio = context.devicePixelRatio;

    final size = min((screenWidth * pixelRatio) ~/ 1, 1920);
    return ImageAttachmentThumbnail(
      resizeHeight: size,
      resizeWidth: size,
      image: Attachment(imageUrl: url),
      fit: BoxFit.cover,
    );
  }
}

class UserProfileMentionedPostsPage extends StatefulWidget {
  const UserProfileMentionedPostsPage({super.key});

  @override
  State<UserProfileMentionedPostsPage> createState() =>
      _UserProfileMentionedPostsPageState();
}

class _UserProfileMentionedPostsPageState
    extends State<UserProfileMentionedPostsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        const EmptyPosts(icon: Icons.person_pin_outlined),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
