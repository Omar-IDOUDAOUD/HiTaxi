import 'package:flutter/material.dart';
import 'package:hitaxi/core/constants/color.dart';

abstract class ThemesCst {
ThemesCst._(); 


  static ThemeData light = new ThemeData(
    backgroundColor: ColorsCst.clral,
    fontFamily: "Arial",
    colorScheme: ColorScheme.light(
        primary: ColorsCst.clrfl,
        secondary: ColorsCst.clrel,
        surface: ColorsCst.clracl),
  );

  static ThemeData dark = new ThemeData(
    backgroundColor: ColorsCst.clrad,
    fontFamily: "Arial",
    colorScheme: ColorScheme.dark(
      primary: ColorsCst.clrfd,
      secondary: ColorsCst.clred,
      surface: ColorsCst.clracd,
    ),
  );
}
