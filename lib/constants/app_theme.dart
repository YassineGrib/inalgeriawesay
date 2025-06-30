import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.algerianGreen,
        primary: AppColors.algerianGreen,
        secondary: AppColors.algerianRed,
        surface: AppColors.algerianWhite,
        error: AppColors.error,
        onPrimary: AppColors.textLight,
        onSecondary: AppColors.textLight,
        onSurface: AppColors.textPrimary,
        onError: AppColors.textLight,
      ),
      
      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.algerianGreen,
        foregroundColor: AppColors.textLight,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      
      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.algerianWhite,
        elevation: 4,
        shadowColor: AppColors.algerianGreen.withValues(alpha: 0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.algerianGreen,
          foregroundColor: AppColors.textLight,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      
      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.algerianGreen,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      
      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.algerianGreen,
          side: const BorderSide(color: AppColors.algerianGreen),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.algerianGreen),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.algerianGreen, width: 2),
        ),
        labelStyle: const TextStyle(color: AppColors.textSecondary),
        hintStyle: const TextStyle(color: AppColors.textSecondary),
      ),
      
      // Text Theme
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 14,
        ),
        bodySmall: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12,
        ),
      ),
      
      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.algerianRed,
        foregroundColor: AppColors.textLight,
        elevation: 6,
      ),
      
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.algerianWhite,
        selectedItemColor: AppColors.algerianGreen,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
      ),
      
      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.backgroundLight,
        selectedColor: AppColors.algerianGreen,
        labelStyle: const TextStyle(color: AppColors.textPrimary),
        secondaryLabelStyle: const TextStyle(color: AppColors.textLight),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
  
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.algerianGreen,
        brightness: Brightness.dark,
        primary: AppColors.lightGreen,
        secondary: AppColors.lightRed,
        surface: AppColors.backgroundDark,
        error: AppColors.error,
        onPrimary: AppColors.textLight,
        onSecondary: AppColors.textLight,
        onSurface: AppColors.textLight,
        onError: AppColors.textLight,
      ),
      
      // App Bar Theme for dark mode
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundDark,
        foregroundColor: AppColors.textLight,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      
      // Card Theme for dark mode
      cardTheme: CardThemeData(
        color: AppColors.backgroundDark,
        elevation: 4,
        shadowColor: AppColors.lightGreen.withValues(alpha: 0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
