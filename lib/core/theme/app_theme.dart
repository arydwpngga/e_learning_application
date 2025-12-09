import 'package:e_learning_application/bloc/font/font_state.dart';
import 'package:e_learning_application/core/theme/app_colors.dart';
import 'package:e_learning_application/core/theme/app_typography.dart';
import 'package:e_learning_application/services/font_service.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getLightTheme(FontState fontState) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        error: AppColors.error,
        surface: AppColors.lightSurface,
      ),
      textTheme: FontService.getCustomTextTheme(
        AppTypography.lightTextTheme,
        fontState.fontScale,
        fontState.fontFamily,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
          padding: EdgeInsets.symmetric(vertical: 10),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.lightDivider),
        ),
      )
    );
  }
}
