import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/utils/material_color.dart';

class AppTheme {
  static ThemeData get theme => ThemeData(
        fontFamily: "OpenSans",
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: MaterialAppColor.primaryColor),
        scaffoldBackgroundColor: AppColors.white,
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(
            0xffF6F6F6,
          ),
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
          ),
          centerTitle: true,
          // titleTextStyle: FontStyleUtilities.h3(
          //   fontWeight: FWT.medium,
          // ),
        ),
      );
}
