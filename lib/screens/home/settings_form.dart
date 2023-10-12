import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signinauth/models/user.dart';
import 'package:signinauth/services/database.dart';
import 'package:signinauth/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // UserData? userData = snapshot.data;
            UserData userData = snapshot.data ??
                UserData(uid: '', name: '', sugars: '0', strength: 100);

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your brew settings',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: userData?.name,
                    style: TextStyle(color: Colors.white), // Text color
                    decoration: InputDecoration(
                      fillColor: Colors.green[200], // Background color
                      filled: true,
                      hintText: 'Enter your text',
                      hintStyle:
                          TextStyle(color: Colors.grey), // Hint text color
                      contentPadding:
                          EdgeInsets.all(16.0), // Padding around the text
                      border: OutlineInputBorder(
                        // Customize the border
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: Colors.transparent), // Hide the border
                      ),
                      enabledBorder: OutlineInputBorder(
                        // Customize the enabled border
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: const Color.fromARGB(
                                0, 145, 29, 29)), // Hide the border
                      ),
                    ),
                    validator: (val) =>
                        val?.isEmpty ?? true ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),

                  SizedBox(height: 20.0),
                  //dropdown
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      fillColor: Colors.green[200], // Background color
                      filled: true,
                      hintText: 'Enter your text',
                      hintStyle:
                          TextStyle(color: Colors.grey), // Hint text color
                      contentPadding:
                          EdgeInsets.all(16.0), // Padding around the text
                      border: OutlineInputBorder(
                        // Customize the border
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: Colors.transparent), // Hide the border
                      ),
                      enabledBorder: OutlineInputBorder(
                        // Customize the enabled border
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: const Color.fromARGB(
                                0, 145, 29, 29)), // Hide the border
                      ),
                    ),
                    value: _currentSugars ?? userData!.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text("$sugar sugars"),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSugars = val),
                  ),
                  //slider
                  Slider(
                      value: (_currentStrength ?? userData.strength).toDouble(),
                      activeColor:
                          Colors.brown[_currentStrength ?? userData.strength]!,
                      inactiveColor:
                          Colors.brown[_currentStrength ?? userData.strength]!,
                      min: 100.0,
                      max: 900.0,
                      divisions: 8,
                      onChanged: (val) => setState(
                            () => _currentStrength = val.round(),
                          )),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[400],
                      foregroundColor: Colors.white54,
                    ),
                    onPressed: () async {
                      // print(_currentName);
                      // print(_currentSugars);
                      // print(_currentStrength);
                      if (_formKey.currentState!.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentSugars ?? userData.sugars,
                            _currentName ?? userData.name,
                            _currentStrength ?? userData.strength);
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Update'),
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
