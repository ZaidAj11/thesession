import 'package:flutter/material.dart';
import 'package:thesession/pages/login_page.dart';
import 'package:thesession/pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) return LoginPage(showRegisterPage: toggleScreens);
    return RegisterPage(
      showLoginPage: toggleScreens,
    );
  }
}
