import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import 'package:signinauth/models/user.dart';

class AuthService {
  final FirebaseAuth.FirebaseAuth _auth = FirebaseAuth.FirebaseAuth.instance;

//create User object based on firebase userid
  User _userFromFirebaseUser(FirebaseAuth.User? user) {
    //Use UserCredential instead of FirebaseUser

    return user != null
        ? User(uid: user.uid)
        : User(uid: ''); // Return an empty User object if user is null
  }
  //sign-in : Anonymous

  Future<User?> signinAnonymous() async {
    try {
      FirebaseAuth.UserCredential result = await _auth
          .signInAnonymously(); // AuthResult has been removed in latest versions , thus use UserCredentials
      User? user = _userFromFirebaseUser(result
          .user); //Instead of firebaseUser , use User with '?' to hold null value
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
