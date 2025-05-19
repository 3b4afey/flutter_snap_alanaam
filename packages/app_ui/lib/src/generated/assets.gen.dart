/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsAnimationsGen {
  const $AssetsAnimationsGen();

  /// File path: assets/animations/checked-animation.json
  String get checkedAnimation =>
      'packages/app_ui/assets/animations/checked-animation.json';

  /// List of all assets
  List<String> get values => [checkedAnimation];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/chat_circle.svg
  SvgGenImage get chatCircle =>
      const SvgGenImage('assets/icons/chat_circle.svg');

  /// File path: assets/icons/facebook.svg
  SvgGenImage get facebook => const SvgGenImage('assets/icons/facebook.svg');

  /// File path: assets/icons/google.svg
  SvgGenImage get google => const SvgGenImage('assets/icons/google.svg');

  /// File path: assets/icons/instagram-reel.svg
  SvgGenImage get instagramReel =>
      const SvgGenImage('assets/icons/instagram-reel.svg');

  /// File path: assets/icons/search.svg
  SvgGenImage get search => const SvgGenImage('assets/icons/search.svg');

  /// File path: assets/icons/setting.svg
  SvgGenImage get setting => const SvgGenImage('assets/icons/setting.svg');

  /// File path: assets/icons/trash.svg
  SvgGenImage get trash => const SvgGenImage('assets/icons/trash.svg');

  /// File path: assets/icons/user.svg
  SvgGenImage get user => const SvgGenImage('assets/icons/user.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        chatCircle,
        facebook,
        google,
        instagramReel,
        search,
        setting,
        trash,
        user,
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// Directory path: assets/images/bg
  $AssetsImagesBgGen get bg => const $AssetsImagesBgGen();

  /// Directory path: assets/images/logo
  $AssetsImagesLogoGen get logo => const $AssetsImagesLogoGen();

  /// Directory path: assets/images/photos
  $AssetsImagesPhotosGen get photos => const $AssetsImagesPhotosGen();
}

class $AssetsVideosGen {
  const $AssetsVideosGen();

  /// File path: assets/videos/sound1.mp4
  String get sound1 => 'packages/app_ui/assets/videos/sound1.mp4';

  /// File path: assets/videos/sound2.mp4
  String get sound2 => 'packages/app_ui/assets/videos/sound2.mp4';

  /// File path: assets/videos/vi1.mp4
  String get vi1 => 'packages/app_ui/assets/videos/vi1.mp4';

  /// File path: assets/videos/vi2.mp4
  String get vi2 => 'packages/app_ui/assets/videos/vi2.mp4';

  /// File path: assets/videos/vi3.mp4
  String get vi3 => 'packages/app_ui/assets/videos/vi3.mp4';

  /// List of all assets
  List<String> get values => [sound1, sound2, vi1, vi2, vi3];
}

class $AssetsImagesBgGen {
  const $AssetsImagesBgGen();

  /// File path: assets/images/bg/clearSideBgNightMode.svg
  SvgGenImage get clearSideBgNightMode =>
      const SvgGenImage('assets/images/bg/clearSideBgNightMode.svg');

  /// File path: assets/images/bg/final.svg
  SvgGenImage get finalSvg => const SvgGenImage('assets/images/bg/final.svg');

  /// File path: assets/images/bg/sideBgNightMode.svg
  SvgGenImage get sideBgNightMode =>
      const SvgGenImage('assets/images/bg/sideBgNightMode.svg');

  /// File path: assets/images/bg/try.svg
  SvgGenImage get trySvg => const SvgGenImage('assets/images/bg/try.svg');

  /// File path: assets/images/bg/verticalBgNightMode.jpg
  AssetGenImage get verticalBgNightModeJpg =>
      const AssetGenImage('assets/images/bg/verticalBgNightMode.jpg');

  /// File path: assets/images/bg/verticalBgNightMode.svg
  SvgGenImage get verticalBgNightModeSvg =>
      const SvgGenImage('assets/images/bg/verticalBgNightMode.svg');

  /// List of all assets
  List<dynamic> get values => [
        clearSideBgNightMode,
        finalSvg,
        sideBgNightMode,
        trySvg,
        verticalBgNightModeJpg,
        verticalBgNightModeSvg,
      ];
}

class $AssetsImagesLogoGen {
  const $AssetsImagesLogoGen();

  /// File path: assets/images/logo/app_logo.svg
  SvgGenImage get appLogo =>
      const SvgGenImage('assets/images/logo/app_logo.svg');

  /// List of all assets
  List<SvgGenImage> get values => [appLogo];
}

class $AssetsImagesPhotosGen {
  const $AssetsImagesPhotosGen();

  /// File path: assets/images/photos/camel_category.png
  AssetGenImage get camelCategory =>
      const AssetGenImage('assets/images/photos/camel_category.png');

  /// File path: assets/images/photos/placeholder.png
  AssetGenImage get placeholder =>
      const AssetGenImage('assets/images/photos/placeholder.png');

  /// File path: assets/images/photos/profile_photo.png
  AssetGenImage get profilePhoto =>
      const AssetGenImage('assets/images/photos/profile_photo.png');

  /// List of all assets
  List<AssetGenImage> get values => [camelCategory, placeholder, profilePhoto];
}

class Assets {
  const Assets._();

  static const String package = 'app_ui';

  static const $AssetsAnimationsGen animations = $AssetsAnimationsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsVideosGen videos = $AssetsVideosGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  static const String package = 'app_ui';

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    @Deprecated('Do not specify package for a generated library asset')
    String? package = package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    @Deprecated('Do not specify package for a generated library asset')
    String? package = package,
  }) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => 'packages/app_ui/$_assetName';
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
      : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
      : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  static const String package = 'app_ui';

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    @Deprecated('Do not specify package for a generated library asset')
    String? package = package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => 'packages/app_ui/$_assetName';
}
