// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:typed_data';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snap_alanaam/app/app.dart';
import 'package:flutter_snap_alanaam/features/feed/feed.dart';
import 'package:flutter_snap_alanaam/features/feed/post/post.dart';
import 'package:flutter_snap_alanaam/features/feed/post/video/widgets/video_player_inherited_widget.dart';
import 'package:flutter_snap_alanaam/features/feed/post/widgets/widgets.dart';
import 'package:flutter_snap_alanaam/features/home/presentation/home.dart';
import 'package:flutter_snap_alanaam/l10n/l10n.dart';
import 'package:flutter_snap_alanaam/app/routes/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:powersync_repository/powersync_repository.dart';
import 'package:snap_alanaam_blocks_ui/snap_alanaam_blocks_ui.dart';
import 'package:shared/shared.dart';

class UserProfileCreatePost extends StatelessWidget {
  const UserProfileCreatePost({
    this.canPop = true,
    this.imagePickerKey,
    this.pickVideo = false,
    this.onPopInvoked,
    this.onBackButtonTap,
    super.key,
    this.wantKeepAlive = true,
  });

  final bool canPop;
  final Key? imagePickerKey;
  final bool pickVideo;
  final bool wantKeepAlive;
  final VoidCallback? onBackButtonTap;
  final VoidCallback? onPopInvoked;

  @override
  Widget build(BuildContext context) {
    final pickerSource = PickerSource.video;
    return WillPopScope(
      onWillPop: () =>
          onPopInvoked == null ? Future.value(true) : Future.value(false),
      child: PickImage().customMediaPicker(
        key: imagePickerKey,
        context: context,
        source: ImageSource.gallery,
        pickerSource: pickerSource,
        multiSelection: false,
        wantKeepAlive: wantKeepAlive,
        onMediaPicked: (details) => context.pushNamed(
          AppRoutes.publishPost.name,
          extra: CreatePostProps(details: details, pickVideo: true),
        ),
        onBackButtonTap:
            onBackButtonTap != null ? () => onBackButtonTap?.call() : null,
      ),
    );
  }
}

class CreatePostProps {
  const CreatePostProps({
    required this.details,
    this.pickVideo = true,
  });

  final SelectedImagesDetails details;
  final bool pickVideo;
}

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({required this.props, super.key});

  final CreatePostProps props;

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  late TextEditingController _captionController;
  late List<Media> _media;

  List<SelectedByte> get selectedFiles => widget.props.details.selectedFiles;

  @override
  void initState() {
    super.initState();
    _captionController = TextEditingController();
    _media = selectedFiles
        .map(
          (e) => e.isThatImage
              ? MemoryImageMedia(bytes: e.selectedByte, id: uuid.v4())
              : MemoryVideoMedia(id: uuid.v4(), file: e.selectedFile),
        )
        .toList();
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  Future<void> _onShareTap(String caption) async {
    void goHome() {
      if (!widget.props.pickVideo) {
        // HomeProvider().animateToPage(1);
        FeedPageController().scrollToTop();

      }
    }

    try {
      toggleLoadingIndeterminate();

      final postId = uuid.v4();
      unawaited(
        FeedPageController().processPostMedia(
          postId: postId,
          selectedFiles: selectedFiles,
          caption: _captionController.text.trim(),
          pickVideo: widget.props.pickVideo,

        ),
      );
      // {
      //   final isReel = selectedFiles.length == 1 &&
      //       selectedFiles.every((e) => !e.isThatImage);
      //   final navigateToReelPage = isReel;
      //   StatefulNavigationShell.of(context)
      //       .goBranch(navigateToReelPage ? 3 : 0, initialLocation: true);
      //
      //     VideoPlayerInheritedWidget.of(context).videoPlayerState.playReels();
      //
      //
      //   late final postId = uuid.v4();
      //
      //   void uploadPost(
      //       {required List<Map<String, dynamic>> media,
      //       required BuildContext contextx}) {
      //     print('+++++++++++++++++++++ uploading');
      //     context.read<FeedBloc>().add(
      //           FeedPostCreateRequested(
      //             postId: postId,
      //             caption: caption,
      //             media: media,
      //           ),
      //         );
      //     print('+++++++++++++++++++++ finished');
      //   }
      //
      //   late final storage = Supabase.instance.client.storage.from('posts');
      //   print('the video is reel ?');
      //   print(isReel);
      //   if (isReel) {
      //     try {
      //       final mediaPath = '$postId/video_0';
      //
      //       final selectedFile = selectedFiles.first;
      //       final firstFrame = await VideoPlus.getVideoThumbnail(
      //         selectedFile.selectedFile,
      //       );
      //       final blurHash = firstFrame == null
      //           ? ''
      //           : await BlurHashPlus.blurHashEncode(firstFrame);
      //       final compressedVideo = (await VideoPlus.compressVideo(
      //             selectedFile.selectedFile,
      //           ))
      //               ?.file ??
      //           selectedFile.selectedFile;
      //       final compressedVideoBytes = await PickImage().imageBytes(
      //         file: compressedVideo,
      //       );
      //       final attachment = AttachmentFile(
      //         size: compressedVideoBytes.length,
      //         bytes: compressedVideoBytes,
      //         path: compressedVideo.path,
      //       );
      //
      //       await storage.uploadBinary(
      //         mediaPath,
      //         attachment.bytes!,
      //         fileOptions: FileOptions(
      //           contentType: attachment.mediaType!.mimeType,
      //           cacheControl: '9000000',
      //         ),
      //       );
      //       final mediaUrl = storage.getPublicUrl(mediaPath);
      //       String? firstFrameUrl;
      //       if (firstFrame != null) {
      //         late final firstFramePath = '$postId/video_first_frame_0';
      //         await storage.uploadBinary(
      //           firstFramePath,
      //           firstFrame,
      //           fileOptions: FileOptions(
      //             contentType: attachment.mediaType!.mimeType,
      //             cacheControl: '9000000',
      //           ),
      //         );
      //         firstFrameUrl = storage.getPublicUrl(firstFramePath);
      //       }
      //       final media = [
      //         {
      //           'media_id': uuid.v4(),
      //           'url': mediaUrl,
      //           'type': VideoMedia.identifier,
      //           'blur_hash': blurHash,
      //           'first_frame_url': firstFrameUrl,
      //         }
      //       ];
      //       print('+++++++++++++++++++++ the media is ');
      //       print(media);
      //
      //       uploadPost(media: media, contextx: context);
      //     } catch (error, stackTrace) {
      //       logE(
      //         'Failed to create reel!',
      //         error: error,
      //         stackTrace: stackTrace,
      //       );
      //     }
      //   } else {
      //     final media = <Map<String, dynamic>>[];
      //     for (var i = 0; i < selectedFiles.length; i++) {
      //       late final selectedByte = selectedFiles[i].selectedByte;
      //       late final selectedFile = selectedFiles[i].selectedFile;
      //       late final isVideo = selectedFile.isVideo;
      //       String blurHash;
      //       Uint8List? convertedBytes;
      //       if (isVideo) {
      //         convertedBytes = await VideoPlus.getVideoThumbnail(
      //           selectedFile,
      //         );
      //         blurHash = convertedBytes == null
      //             ? ''
      //             : await BlurHashPlus.blurHashEncode(
      //                 convertedBytes,
      //               );
      //       } else {
      //         blurHash = await BlurHashPlus.blurHashEncode(
      //           selectedByte,
      //         );
      //       }
      //       late final mediaExtension =
      //           selectedFile.path.split('.').last.toLowerCase();
      //
      //       late final mediaPath =
      //           '$postId/${!isVideo ? 'image_$i' : 'video_$i'}';
      //
      //       Uint8List bytes;
      //       if (isVideo) {
      //         try {
      //           final compressedVideo = await VideoPlus.compressVideo(
      //             selectedFile,
      //           );
      //           bytes = await PickImage().imageBytes(
      //             file: compressedVideo!.file!,
      //           );
      //         } catch (error, stackTrace) {
      //           logE(
      //             'Error compressing video',
      //             error: error,
      //             stackTrace: stackTrace,
      //           );
      //           bytes = selectedByte;
      //         }
      //       } else {
      //         bytes = selectedByte;
      //       }
      //       await storage.uploadBinary(
      //         mediaPath,
      //         bytes,
      //         fileOptions: FileOptions(
      //           contentType: '${!isVideo ? 'image' : 'video'}/$mediaExtension',
      //           cacheControl: '9000000',
      //         ),
      //       );
      //       final mediaUrl = storage.getPublicUrl(mediaPath);
      //       String? firstFrameUrl;
      //       if (convertedBytes != null) {
      //         late final firstFramePath = '$postId/video_first_frame_$i';
      //         await storage.uploadBinary(
      //           firstFramePath,
      //           convertedBytes,
      //           fileOptions: FileOptions(
      //             contentType: 'video/$mediaExtension',
      //             cacheControl: '9000000',
      //           ),
      //         );
      //         firstFrameUrl = storage.getPublicUrl(firstFramePath);
      //       }
      //       final mediaType =
      //           isVideo ? VideoMedia.identifier : ImageMedia.identifier;
      //       if (isVideo) {
      //         media.add({
      //           'media_id': uuid.v4(),
      //           'url': mediaUrl,
      //           'type': mediaType,
      //           'blur_hash': blurHash,
      //           'first_frame_url': firstFrameUrl,
      //         });
      //       } else {
      //         media.add({
      //           'media_id': uuid.v4(),
      //           'url': mediaUrl,
      //           'type': mediaType,
      //           'blur_hash': blurHash,
      //         });
      //       }
      //     }
      //     uploadPost(media: media, contextx: context);
      //   }
      // }
      toggleLoadingIndeterminate(enable: false);
      goHome.call();
    } catch (error, stackTrace) {
      toggleLoadingIndeterminate(enable: false);
      logE('Failed to create post', error: error, stackTrace: stackTrace);
      openSnackbar(
        const SnackbarMessage.error(title: 'Failed to create post!'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      releaseFocus: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: false,
        title: Text(context.l10n.loginText),
      ),
      bottomNavigationBar: PublishPostButton(
        onShareTap: () => _onShareTap(_captionController.text),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: s,
          vertical: s,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostMedia(
              media: _media,
              withLikeOverlay: false,
              withInViewNotifier: false,
              autoHideCurrentIndex: false,
              mediaCarouselSettings: const MediaCarouselSettings.empty(
                viewportFraction: .9,
              ),
            ),
            Gap.v(s),
            CaptionInputField(
              captionController: _captionController,
              caption: _captionController.text.trim(),
              onSubmitted: _onShareTap,
            ),
          ],
        ),
      ),
    );
  }
}

class PublishPostButton extends StatelessWidget {
  const PublishPostButton({required this.onShareTap, super.key});

  final VoidCallback onShareTap;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: context.reversedAdaptiveColor,
      padding: EdgeInsets.zero,
      height: 90,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppDivider(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: md,
              vertical: md,
            ),
            child: Tappable.faded(
              onTap: onShareTap,
              borderRadius: BorderRadius.circular(6),
              backgroundColor: AppColors.kPrimaryColor,
              padding: EdgeInsets.symmetric(
                vertical: md,
                horizontal: s,
              ),
              child: Align(
                child: Text(
                  context.l10n.loginText,
                  style: context.labelLarge,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
