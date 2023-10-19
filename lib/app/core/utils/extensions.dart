import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Create an extension named "PercentSized" on the double data type.
extension PercentSized on double {
  // Create a getter named "hp" (Height Percentage) that calculates the
  // height as a percentage of the screen's height.
  double get hp => (Get.height * (this / 100));

  // Create a getter named "wp" (Width Percentage) that calculates the
  // width as a percentage of the screen's width.
  double get wp => (Get.width * (this / 100));
}

// Create an extension named "ResponsiveText" on the double data type.
extension ResponsiveText on double {
  // Create a getter named "sp" (Scale Percentage) that calculates the
  // text size based on a fraction of the screen's width.
  double get sp => Get.width / 100 * (this / 3);
}


extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
