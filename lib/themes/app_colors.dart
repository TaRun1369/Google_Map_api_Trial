import 'package:flutter/material.dart';
import 'package:screens_for_touristapp/themes/app_theme.dart';
import 'package:screens_for_touristapp/themes/ui_parameters.dart';

const Color onSurfaceTextColor = Colors.white70;

const mainGradientLight = LinearGradient(
    begin : Alignment.topLeft,
    end: Alignment.bottomRight,
    colors:[
      primaryLightColorLight,
      primaryColorLight
    ]
);

// const mainGradientDark = LinearGradient(
//     begin : Alignment.topLeft,
//     end: Alignment.bottomRight,
//     colors:[
//       primaryDarkColorDark,
//       primaryColorDark
//     ]
// );

LinearGradient mainGradient(BuildContext context)=>
    UIParameters.isDarkMode(context)?mainGradientLight:mainGradientLight;