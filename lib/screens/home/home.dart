import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signinauth/models/brew.dart';
import 'package:signinauth/screens/home/brew_list.dart';
import 'package:signinauth/screens/home/settings_form.dart';
import 'package:signinauth/services/auth.dart';
import 'package:signinauth/services/database.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPannel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService(uid: '').brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.deepPurple[300],
        appBar: AppBar(
          title: Text('HOME'),
          backgroundColor: const Color.fromARGB(153, 165, 16, 16),
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            TextButton.icon(
              onPressed: () => _showSettingsPannel(),
              icon: Icon(Icons.settings),
              label: Text('settings'),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                // 2 white spaces (or 1 tab) before assets and 4 white spaces (or 2 tabs) before - images...
                image: AssetImage('assets/coffee_bg.jpg'),
                fit: BoxFit.cover),
          ),
          child: BrewList(),
        ),
      ),
    );
  }
}
