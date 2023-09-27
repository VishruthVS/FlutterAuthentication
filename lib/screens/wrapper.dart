import 'package:flutter/material.dart';
import 'package:signinauth/screens/authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //returns a home screen if the user is logged in , if not returns a authenticate screen
    return Authenticate();
  }
}
