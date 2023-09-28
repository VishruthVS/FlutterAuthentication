import 'package:flutter/material.dart';
import 'package:signinauth/screens/authenticate/register.dart';
import 'package:signinauth/screens/authenticate/sing_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Singin(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
