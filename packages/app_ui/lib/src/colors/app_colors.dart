import 'package:flutter/material.dart';

/// Defines the color palette for the App UI Kit.
abstract class AppColors {
  /// the application primary color
  static const Color kPrimaryColor = Color(0xffBCA006);

  /// the application secondary color
  static const Color kSecondaryColor = Color(0xffE8E8E8);

  /// the application hint color
  static const Color kHintColor = Color(0xffFFFFFF);

  /// Black
  static const Color black = Color(0xFF000000);

  /// The background color.
  static const Color background = Color(0xff0D0D0D);

  /// White
  static const Color white = Color(0xFFFFFFFF);

  /// Transparent
  static const Color transparent = Color(0x00000000);

  /// The light blue color.
  static const Color lightBlue = Color.fromARGB(255, 100, 181, 246);

  /// The blue primary color and swatch.
  static const Color blue = Color(0xFF3898EC);

  /// The deep blue color.
  static const Color deepBlue = Color(0xff337eff);

  /// The border outline color.
  static const Color borderOutline = Color.fromARGB(45, 250, 250, 250);

  /// Light dark.
  static const Color lightDark = Color.fromARGB(164, 120, 119, 119);

  /// Dark.
  static const Color dark = Color.fromARGB(255, 58, 58, 58);

  /// Primary dark blue color.
  static const Color primaryDarkBlue = Color(0xff1c1e22);

  /// Grey.
  static const Color grey = Colors.grey;

  /// The bright grey color.
  static const Color brightGrey = Color.fromARGB(255, 224, 224, 224);

  /// The dark grey color.
  static const Color darkGrey = Color.fromARGB(255, 66, 66, 66);

  /// The emphasize grey color.
  static const Color emphasizeGrey = Color.fromARGB(255, 97, 97, 97);

  /// The emphasize dark grey color.
  static const Color emphasizeDarkGrey = Color.fromARGB(255, 40, 37, 37);

  /// Red material color.
  static const MaterialColor red = Colors.red;

  /// The primary Instagram gradient pallete.
  static const primaryGradient = <Color>[
    Color(0xFF0E0C00), // Red-pink
    Color(0xff957F04), // Purple
    Color(0xff957f04), // Purple
    Color(0xFF7A6A16), // Orange
    Color(0xFFFDEFA0), // Duplicate of the first color
    // Color(0xFFC13584), // Red-purple
  ];

  /// The primary Telegram gradient chat background pallete.
  static const primaryBackgroundGradient = <Color>[
    Color.fromARGB(255, 149, 127, 4),
    Color.fromARGB(255, 122, 106, 22),
    Color.fromARGB(255, 253, 239, 160),
    Color.fromARGB(255, 111, 156, 189),
  ];

  /// The primary Telegram gradient chat message bubble pallete.
  static const primaryMessageBubbleGradient = <Color>[
    Color.fromARGB(255, 226, 128, 53),
    Color.fromARGB(255, 149, 127, 4),
    Color.fromARGB(255, 191, 179, 117),
    Color.fromARGB(255, 78, 173, 195),
  ];
}
