import 'package:ai_email/src/screens/login_screen/auth_login_controller.dart';
import 'package:ai_email/src/shared/themes.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyIt',
      home: const AuthLoginController(),
      theme: AppThemes.themeLight,
    );
  }
}
