import 'package:app_ui/app_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_snap_alanaam/l10n/l10n.dart';
import 'package:shared/shared.dart';
import 'package:snap_alanaam_blocks_ui/snap_alanaam_blocks_ui.dart';
// import 'package:stories_editor/stories_editor.dart';

void initUtilities(BuildContext context, Locale locale) {
  final isSameLocal = Localizations.localeOf(context) == locale;
  if (isSameLocal) return;

  final l10n = context.l10n;
  final t = context.t;

  PickImage().init(
    tabsTexts: TabsTexts(
      photoText: l10n.loginText,
      videoText: l10n.loginText,
      acceptAllPermissions: l10n.loginText,
      clearImagesText: l10n.loginText,
      deletingText: l10n.loginText,
      galleryText: l10n.loginText,
      holdButtonText: l10n.loginText,
      noMediaFound: l10n.loginText,
      notFoundingCameraText: l10n.loginText,
      noCameraFoundText: l10n.loginText,
      newPostText: l10n.loginText,
      newAvatarImageText: l10n.loginText,
    ),
  );
  BlockSettings().init(
    postDelegate: PostTextDelegate(
      cancelText: l10n.loginText,
      editText: l10n.loginText,
      deleteText: l10n.loginText,
      deletePostText: l10n.loginText,
      deletePostConfirmationText: l10n.loginText,
      notShowAgainText: l10n.loginText,
      blockAuthorConfirmationText: l10n.loginText,
      blockAuthorText: l10n.loginText,
      blockPostAuthorText: l10n.loginText,
      blockText: l10n.loginText,
      noPostsText: l10n.loginText,
      visitSponsoredInstagramProfileText: l10n.loginText,
      likedByText: (count, name, onUsernameTap) => t.likedBy(
        name: TextSpan(
          text: name,
          style: context.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          recognizer: TapGestureRecognizer()..onTap = onUsernameTap,
        ),
        and: TextSpan(text: count < 1 ? '' : l10n.loginText),
        others: TextSpan(
          text: l10n.loginText,
          style: context.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      sponsoredPostText: l10n.loginText,
      likesCountText: (p0) {
        return l10n.loginText;
      },
      likesCountShortText: (p0) {
        return l10n.loginText;
      },
    ),
    commentDelegate: CommentTextDelegate(
      seeAllCommentsText: (p0) {
        return l10n.loginText;
      },
      replyText: l10n.loginText,
    ),
    followDelegate: FollowTextDelegate(
      followText: l10n.loginText,
      followingText: l10n.loginText,
    ),
  );
}

// StoriesEditorLocalizationDelegate storiesEditorLocalizationDelegate(
//     BuildContext context,
//     ) {
//   final l10n = context.l10n;
//   return StoriesEditorLocalizationDelegate(
//     cancelText: l10n.cancelText,
//     discardEditsText: l10n.discardEditsText,
//     discardText: l10n.discardText,
//     doneText: l10n.doneText,
//     draftEmpty: l10n.draftEmpty,
//     errorText: l10n.errorText,
//     loseAllEditsText: l10n.loseAllEditsText,
//     saveDraft: l10n.saveDraft,
//     successfullySavedText: l10n.successfullySavedText,
//     tapToTypeText: l10n.tapToTypeText,
//     uploadText: l10n.uploadText,
//   );
// }
