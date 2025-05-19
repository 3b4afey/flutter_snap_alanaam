import 'package:app_ui/app_ui.dart' as App;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snap_alanaam/app/app.dart';
import 'package:flutter_snap_alanaam/features/user_profile/user_profile.dart';

class UserSliverAppBar extends StatelessWidget {
  const UserSliverAppBar({
    super.key,
    // ,this.sponsoredPost
    required this.fullName,
  });

  final String fullName;

  // final PostSponsoredBlock? sponsoredPost;

  @override
  Widget build(BuildContext context) {
    final isOwner = context.select((UserProfileBloc bloc) => bloc.isOwner);
    final followers =
        context.select((UserProfileBloc b) => b.state.followersCount);
    final followings =
        context.select((UserProfileBloc b) => b.state.followingsCount);
    final user = context.select((UserProfileBloc b) => b.state.user);
    // final user$ = context.select((UserProfileBloc b) => b.state.user);
    // final user = sponsoredPost == null
    //     ? user$
    //     : user$.isAnonymous
    //     ? sponsoredPost!.author.toUser
    //     : user$;

    return SliverPadding(
      padding: EdgeInsets.only(right: App.md),
      sliver: SliverAppBar(
        centerTitle: true,
        pinned: !ModalRoute.of(context)!.isFirst,
        floating: ModalRoute.of(context)!.isFirst,
        title: Text(
          '${user.displayUsername}',
          style: context.titleSmall?.copyWith(
            fontWeight: FontWeight.w300,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          if (!isOwner)
            const UserProfileActions()
          else ...[
            const UserProfileAddMediaButton(),
            if (ModalRoute.of(context)?.isFirst ?? false) ...[
              App.Gap.h(App.md),
              UserProfileSettingsButton(),
            ],
          ],
        ],
      ),
    );
  }
}
