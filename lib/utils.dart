import 'dart:ui' as ui;
import 'dart:ui';

class Utils {
  static double deviceWidth =
      ui.window.physicalSize.width / ui.window.devicePixelRatio;
  static double deviceHeight =
      ui.window.physicalSize.height / ui.window.devicePixelRatio;
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  static String getTransparentHexColor(String hexColor) {
    // Ensure the hex color is valid
    RegExp hexColorRegExp = RegExp(r'^#?([a-fA-F0-9]{6})$');
    if (!hexColorRegExp.hasMatch(hexColor)) {
      throw FormatException('Invalid hex color format');
    }

    // Remove the # if it exists
    hexColor = hexColor.replaceAll('#', '');

    // Add 50% opacity (80 in hex)
    return '#1A$hexColor';
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
