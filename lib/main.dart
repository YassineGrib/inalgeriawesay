import 'package:flutter/material.dart';
import 'constants/app_theme.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const InAlgeriaWeSayApp());
}

class InAlgeriaWeSayApp extends StatelessWidget {
  const InAlgeriaWeSayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'In Algeria We Say',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


