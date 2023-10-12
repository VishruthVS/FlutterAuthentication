import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:signinauth/models/brew.dart';
import 'package:signinauth/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  //collection refernce
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

//brew list form snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
        name: doc.get('name') ?? " ",
        sugars: doc.get('sugars') ?? '0',
        strength: doc.get('strength') ?? 0,
      );
    }).toList(); // Convert the Iterable to a List
  }

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        sugars: snapshot['sugars'],
        strength: snapshot['strength'],
        name: snapshot['name']);
  }

  //get brew streams
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map((_userDataFromSnapshot));
  }
}
