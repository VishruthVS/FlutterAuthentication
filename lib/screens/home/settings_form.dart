import 'package:flutter/material.dart';

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
            style: TextStyle(color: Colors.white), // Text color
            decoration: InputDecoration(
              fillColor: Colors.green[200], // Background color
              filled: true,
              hintText: 'Enter your text',
              hintStyle: TextStyle(color: Colors.grey), // Hint text color
              contentPadding: EdgeInsets.all(16.0), // Padding around the text
              border: OutlineInputBorder(
                // Customize the border
                borderRadius: BorderRadius.circular(10.0),
                borderSide:
                    BorderSide(color: Colors.transparent), // Hide the border
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
              hintStyle: TextStyle(color: Colors.grey), // Hint text color
              contentPadding: EdgeInsets.all(16.0), // Padding around the text
              border: OutlineInputBorder(
                // Customize the border
                borderRadius: BorderRadius.circular(10.0),
                borderSide:
                    BorderSide(color: Colors.transparent), // Hide the border
              ),
              enabledBorder: OutlineInputBorder(
                // Customize the enabled border
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                    color: const Color.fromARGB(
                        0, 145, 29, 29)), // Hide the border
              ),
            ),
            value: _currentSugars ?? '0',
            items: sugars.map((sugar) {
              return DropdownMenuItem(
                value: sugar,
                child: Text("$sugar sugars"),
              );
            }).toList(),
            onChanged: (val) => setState(() => _currentSugars = val),
          ),
          //slider
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink[400],
              foregroundColor: Colors.white54,
            ),
            onPressed: () async {
              print(_currentName);
              print(_currentSugars);
              print(_currentStrength);
            },
            child: Text('Update'),
          )
        ],
      ),
    );
  }
}
