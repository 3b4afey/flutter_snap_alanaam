import 'package:app_ui/app_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snap_alanaam/app/app.dart';
import 'package:flutter_snap_alanaam/features/user_profile/user_profile.dart';
import 'package:snap_alanaam_blocks_ui/snap_alanaam_blocks_ui.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({super.key, required this.isOwner});

  final bool isOwner;

  @override
  Widget build(BuildContext context) {
    final user = context.select((UserProfileBloc b) => b.state.user);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ClipOval(
        //   child: CachedNetworkImage(
        //     fit: BoxFit.cover,
        //     imageUrl:
        //     user.avatarUrl ?? 'https://img.wattpad.com/8f19b412f2223afe4288ed0904120a48b7a38ce1/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f776174747061642d6d656469612d736572766963652f53746f7279496d6167652f5650722d38464e2d744a515349673d3d2d3234323931353831302e313434336539633161633764383437652e6a7067' ,
        //     height: 100.0,
        //     width: 100.0,
        //     placeholder: (context, url) =>
        //         CircularProgressIndicator(),
        //     errorWidget: (context, url, error) =>
        //         Icon(Icons.error),
        //   ),
        // ),
        UserProfileAvatar(
          avatarUrl: user.avatarUrl,
          radius: 46,
          onLongPress: (avatarUrl) =>
              avatarUrl == null ? null : context.showImagePreview(avatarUrl),
          onTap: (imageUrl) {
            if (imageUrl == null) return;
            if (!isOwner) context.showImagePreview(imageUrl);
            if (isOwner) {}
          },
        )
      ],
    );
  }
}
