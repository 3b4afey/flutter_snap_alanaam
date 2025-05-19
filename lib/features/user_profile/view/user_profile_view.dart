import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snap_alanaam/features/user_profile/user_profile.dart';
import 'package:posts_repository/posts_repository.dart';
import 'package:user_repository/user_repository.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView(
      {super.key,
      required this.userId,
      this.props = const UserProfileProps.build()});

  final String userId;
  final UserProfileProps props;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserProfileBloc(
          userRepository: context.read<UserRepository>(),
          userId: userId,
          postsRepository: context.read<PostsRepository>())
        ..add(UserProfileSubscriptionRequested())
        ..add(UserProfilePostsCountSubscriptionRequested())
        ..add(UserProfileFollowingsCountSubscriptionRequested())
        ..add(UserProfileFollowersCountSubscriptionRequested()),
      child: UserProfilePage(
        userId: userId,
        props: props,
      ),
    );
  }
}
