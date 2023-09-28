import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signinauth/models/user.dart';
import 'package:signinauth/screens/authenticate/authenticate.dart';
import 'package:signinauth/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    print(user);

    //returns a home screen if the user is logged in , if not returns a authenticate screen
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
    // return Authenticate();
  }
}
