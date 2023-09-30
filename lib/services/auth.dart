import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import 'package:signinauth/models/user.dart';
import 'package:signinauth/services/database.dart';

class AuthService {
  final FirebaseAuth.FirebaseAuth _auth = FirebaseAuth.FirebaseAuth.instance;

//create User object based on firebase userid
  User? _userFromFirebaseUser(FirebaseAuth.User? user) {
    //Use UserCredential instead of FirebaseUser

    return user != null ? User(uid: user.uid) : null;
    // Return an empty User object if user is null
  }

  // Auth changes using stream
  Stream<User?> get user {
    return _auth
        .authStateChanges()
        // .map((firebaseUser) => _userFromFirebaseUser(firebaseUser));
        .map(_userFromFirebaseUser);
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
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      FirebaseAuth.UserCredential result = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      FirebaseAuth.User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Register with email/password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      FirebaseAuth.UserCredential result = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      FirebaseAuth.User? user = result.user;

      //create a new document for the user with the uid

      if (user != null) {
        //create a new document for the user with the uid
        await DatabaseService(uid: user.uid)
            .updateUserData('0', 'vishruth_user', 100);
        return _userFromFirebaseUser(user);
      } else {
        print('User is null');
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
