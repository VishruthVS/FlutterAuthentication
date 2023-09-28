import 'package:flutter/material.dart';
import 'package:signinauth/services/auth.dart';

class Singin extends StatefulWidget {
  const Singin({super.key});

  @override
  State<Singin> createState() => _SinginState();
}

class _SinginState extends State<Singin> {
  final AuthService _auth = AuthService();

  //text field state
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[300],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 181, 181, 48),
        elevation: 0.0,
        title: Text('sign in'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        // child: ElevatedButton(
        //   style: ButtonStyle(
        //     backgroundColor: MaterialStateProperty.all<Color>(Colors.white54),
        //   ),
        //   onPressed: () async {
        //     dynamic result = await _auth.signinAnonymous();
        //     if (result == null) {
        //       print('Error signing in');
        //     } else {
        //       print('Signed in succesfully');
        //       print('User UID: ${result.uid}');
        //     }
        //   },
        //   child: Text('Sing in anom'),
        // ),
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(onChanged: (val) {
                setState(() => email = val);
              }),
              SizedBox(height: 20.0),
              TextFormField(
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => password = val);
                  }),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  print(email);
                  print(password);
                },
                child: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.black87),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white54),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
