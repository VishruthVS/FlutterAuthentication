import 'package:flutter/material.dart';
import 'package:signinauth/services/auth.dart';

class Singin extends StatefulWidget {
  final Function toggleView;

  const Singin({super.key, required this.toggleView});

  @override
  State<Singin> createState() => _SinginState();
}

class _SinginState extends State<Singin> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[300],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 181, 181, 48),
        elevation: 0.0,
        title: Text('sign in'),
        actions: <Widget>[
          TextButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: Icon(Icons.person),
            label: Text('Register'),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),

        //FOR ANONYMOUS SIGN_IN
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
        //FOR EMAIL/PASSWORD LOGIN
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(validator: (val) {
                if (val?.isEmpty ?? true) {
                  return 'Enter an email';
                }
                if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                    .hasMatch(val!)) {
                  return 'Enter a valid email address';
                }
                return null;
              }, onChanged: (val) {
                setState(() => email = val);
              }),
              SizedBox(height: 20.0),
              TextFormField(
                  validator: (val) {
                    if ((val?.length ?? 0) < 6) {
                      return 'Enter a password of 6+ characters';
                    }
                    return null;
                  },
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => password = val);
                  }),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Form is valid
                    dynamic result =
                        await _auth.signInWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() => error =
                          'Could not sign with the provided credentials..!');
                    }
                  }
                },
                child: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.black87),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white54),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
