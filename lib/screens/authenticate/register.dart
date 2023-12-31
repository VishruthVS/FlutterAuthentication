import 'package:flutter/material.dart';
import 'package:signinauth/services/auth.dart';
import 'package:signinauth/shared/constants.dart';
import 'package:signinauth/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.teal[300],
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 181, 181, 48),
              elevation: 0.0,
              title: Text('Sign up'),
              actions: <Widget>[
                TextButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(Icons.person),
                  label: Text('Sign in'),
                ),
              ],
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
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    // TextFormField(
                    //   validator: (val) =>
                    //       val?.isEmpty ?? true ? 'Enter an email' : null,
                    //   onChanged: (val) {
                    //     setState(() =>
                    //         email = val); // Assign an empty string if val is null
                    //   },
                    // ),
                    //OR
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) {
                        if (val?.isEmpty ?? true) {
                          return 'Enter an email';
                        }
                        if (!RegExp(
                                r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                            .hasMatch(val!)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),

                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
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
                          setState(() => loading = true);
                          // Form is valid
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error = 'Kindly enter a valid email..!';
                              loading = false;
                            });
                          }
                        }
                      },
                      child: Text(
                        'Register',
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
