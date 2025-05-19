import 'package:flutter/material.dart';
import 'package:app_ui/app_ui.dart' as App;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snap_alanaam/app/app_bloc/app_bloc.dart';
import 'package:flutter_snap_alanaam/features/user_profile/user_profile.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

class UserProfileHeader extends StatelessWidget {
  const UserProfileHeader({super.key, required this.userId});

  final String userId;

  void _pushToUserStatisticInfo(BuildContext context,
          {required int tabIndex}) =>
      context.pushNamed('user_statistics',
          queryParameters: {'user_id': userId}, extra: tabIndex);

  @override
  Widget build(BuildContext context) {
    // final user = context.select((AppBloc bloc)=> bloc.state.user);
    final isOwner = context.select((UserProfileBloc bloc) => bloc.isOwner);
    final user = context.select((UserProfileBloc b) => b.state.user);

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: App.md, vertical: App.md),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            ProfilePic(
              isOwner: isOwner,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              user.displayFullName,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            ProfileAccountStats(
              onStatisticTap: (tabIndex) =>
                  _pushToUserStatisticInfo(context, tabIndex: tabIndex),
            ),
            SizedBox(
              height: 25,
            ),
            App.Gap.v(App.md),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isOwner)
                  ...<Widget>[
                    const Flexible(flex: 3, child: EditProfileButton()),
                    const Flexible(flex: 3, child: ShareProfileButton()),
                    const Flexible(child: ShowSuggestedPeopleButton()),
                  ].spacerBetween(width: App.s)
                else ...[
                  const Expanded(
                    flex: 3,
                    child: UserProfileFollowUserButton(),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
