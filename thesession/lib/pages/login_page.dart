// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thesession/main.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers for textFields

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late FocusNode _focusNode = new FocusNode();
  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } catch (exception) {
      _emailController.clear();
      _passwordController.clear();
      showSnackBar(context, "Incorrect email or password...");
    }
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      backgroundColor: Color.fromARGB(255, 178, 63, 55),
      content: Text(text),
      duration: Duration(seconds: 1), //default is 4s
    );
    // Find the Scaffold in the widget tree and use it to show a SnackBar.
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(height: 60),

                Icon(
                  Icons.lock,
                  size: 80,
                ),
                SizedBox(height: 20),

                // Welcome message
                Text(
                  "Hello again!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Welcome back, you've been missed...",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),

                SizedBox(height: 20),

                // Input boxes for email/password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                        child: TextField(
                          onSubmitted: ((value) => {_focusNode.requestFocus()}),
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                          ),
                        ),
                      )), // Container
                ),

                SizedBox(height: 20),

                // Password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                      child: TextField(
                        focusNode: _focusNode,
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                        ),
                      ),
                    ),
                  ), // Container
                ),

                SizedBox(height: 20),

                // Sign in button

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: signIn,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: MyApp.checkIfDarkModeEnabled(context)
                            ? AppColours.DefaultDarkColour
                            : AppColours.DefaultDarkColour,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          "Sign in",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                // register message

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a member? "),
                    GestureDetector(
                      onTap: widget.showRegisterPage,
                      child: Text(
                        "Register now!",
                        style:
                            TextStyle(color: Color.fromARGB(255, 93, 243, 33)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
