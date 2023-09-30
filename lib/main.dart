import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signinauth/models/user.dart';
import 'package:signinauth/screens/wrapper.dart';
import 'package:signinauth/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  debugPrint = (String? message, {int? wrapWidth}) {
    // You can customize how the logs are printed here
    print(message);
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: AuthService().user,
      initialData: null, // You can set this to null or an empty user object
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
