import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign-in : Anonymous

  Future signinAnonymous() async {
    try {
      UserCredential result = await _auth
          .signInAnonymously(); // AuthResult has been removed in latest versions , thus use UserCredentials
      User? user = result
          .user; //Instead of firebaseUser , use User with '?' to hold null value
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //sign-in : Email/Password
  // Register with email/password
  //sign out
}
