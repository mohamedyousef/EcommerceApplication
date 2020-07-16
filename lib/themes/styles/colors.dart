import 'package:flutter/material.dart';
class ColorsStyles{

  static  Color blue = Color.fromARGB(220, 23, 34, 59);
  static Color deepyellow = Color.fromARGB(250, 247, 201, 58);
  static Color lightyellow = HexColor.fromHex("#FCE0A2");
  static Color whitegrey =  HexColor.fromHex("#f1f1f1");
  static Color whitegreyF4 =  HexColor.fromHex("#f4f4f4");
  static Color purpleLIGT =  HexColor.fromHex("#443F67");
  static Color greenHole2 =  HexColor.fromHex("#4a4949");
  static Color pink_white =  HexColor.fromHex("#FFDDC7");
  static Color yellow_white =  HexColor.fromHex("#FFE28C");
  static Color green_light_white =  HexColor.fromHex("#84C4C8");
  static Color orange_light_white =  HexColor.fromHex("#FFA583");
  static Color pink_light_white =  HexColor.fromHex("#FFBEB6");
  static Color green_holy_white =  HexColor.fromHex("#C1C7AB");
  static Color color_purple_lapitdark =  HexColor.fromHex("#673bb7");
  static Color color_yellow_mid =  HexColor.fromHex("#FFC000");
  static  Color coffe_color_Grey = HexColor.fromHex("#E4E0D7");

  static Color purple =  Colors.indigo.shade600;
  static List<Color> purpleGradient = [HexColor.fromHex("#a7a6cb"),HexColor.fromHex("#8989ba")];
  static List<Color> purple2Gradient = [HexColor.fromHex("#8989ba"),HexColor.fromHex("#a7a6cb")];
  static List<Color> orangeGradient = [HexColor.fromHex("#fc6076"),HexColor.fromHex("#ff9a44")];
  static List<Color> orangeLightGradient = [HexColor.fromHex("#f0ac54"),HexColor.fromHex("#e87838")];
  static List<Color> blueGradient = [HexColor.fromHex("#4481eb"),HexColor.fromHex("#04befe")];
  static List<Color> pinkGradient = [HexColor.fromHex("#ed6ea0"),HexColor.fromHex("#ec8c69")];
  static List<Color> greenGradient = [HexColor.fromHex("#007adf"),HexColor.fromHex("#00ecbc")];
  static List<Color> blueHoleGradient = [HexColor.fromHex("#243949"),HexColor.fromHex("#517fa4")];
  static List<Color> bluewithSeconGradient = [HexColor.fromHex("#8989ba"),HexColor.fromHex("#a7a6cb")];
  static List<Color> bluelightGradient = [HexColor.fromHex("#4481eb"),HexColor.fromHex("#4481eb"),HexColor.fromHex("#04befe")];

  static Color greenHole = HexColor.fromHex("#243949");
  static Color indiagoLight = HexColor.fromHex("#F6999");


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
      '${alpha.toRadixString(16)}'
      '${red.toRadixString(16)}'
      '${green.toRadixString(16)}'
      '${blue.toRadixString(16)}';
}