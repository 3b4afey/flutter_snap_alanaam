import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snap_alanaam/app/app_bloc/app_bloc.dart';
import 'package:flutter_snap_alanaam/l10n/l10n.dart';
import 'package:go_router/go_router.dart';

class UserProfileAddMediaButton extends StatelessWidget {
  const UserProfileAddMediaButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return Tappable.faded(
      onTap: () => context
          .showListOptionsModal(
        title: l10n.loginText,
        options: createMediaModalOptions(
          // postLabel: 'Post Label',
          context: context,
          reelLabel: l10n.loginText,
          storyLabel: l10n.loginText,
          enableStory: false,
          goTo: (route, {extra}) => context.pushNamed(route, extra: extra),
          // onStoryCreated: (path) {
          //   context.read<CreateStoriesBloc>().add(
          //     CreateStoriesStoryCreateRequested(
          //       author: user,
          //       contentType: StoryContentType.image,
          //       filePath: path,
          //       onError: (_, __) {
          //         toggleLoadingIndeterminate(enable: false);
          //         openSnackbar(
          //           SnackbarMessage.error(
          //             title: l10n.somethingWentWrongText,
          //             description: l10n.failedToCreateStoryText,
          //           ),
          //         );
          //       },
          //       onLoading: toggleLoadingIndeterminate,
          //       onStoryCreated: () {
          //         toggleLoadingIndeterminate(enable: false);
          //         openSnackbar(
          //           SnackbarMessage.success(
          //             title: l10n.successfullyCreatedStoryText,
          //           ),
          //           clearIfQueue: true,
          //         );
          //       },
          //     ),
          //   );
          //   context.pop();
          // },
        ),
      )
          .then((option) {
        if (option == null) return;
        void onTap() => option.onTap(context);
        onTap.call();
      }),
      child: const Icon(
        Icons.add_box_outlined,
        size: AppSize.iconSize,
      ),
    );
  }
}
