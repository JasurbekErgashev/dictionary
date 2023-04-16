import 'package:dictionary/constants/constants.dart';
import 'package:flutter/material.dart';

class DictionaryTheme {
  static ThemeData theme() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.lightLavender,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.lightLavender,
        foregroundColor: AppColors.blueGrey,
      ),
      fontFamily: 'Montserrat',
      bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.lightLavender,
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: AppColors.blueGrey,
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: 'Montserrat',
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: 'Montserrat',
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 2,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}
