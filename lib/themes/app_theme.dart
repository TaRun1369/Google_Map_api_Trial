import 'package:flutter/material.dart';
import 'package:screens_for_touristapp/themes/data_mixing.dart';

const Color primaryLightColorLight = Color(0xFF4FC3F7);
const Color primaryColorLight = Color(0xFFB2FF59);
const Color mainTextColorLight = Color.fromARGB(255, 40, 40, 40);
class LightTheme  with SubThemeData{
  buildLightTheme(){
    final ThemeData systemLightTheme = ThemeData.light();
    return systemLightTheme.copyWith(
        iconTheme:getIconTheme(),
        textTheme: getTextThemes().apply(
          bodyColor: mainTextColorLight,
          displayColor: mainTextColorLight,
        )
    );
  }

}