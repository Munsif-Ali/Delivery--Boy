import 'package:deliveryapp/models/user.dart';
import 'package:deliveryapp/services/auth.dart';
import 'package:deliveryapp/shared/constants.dart';
import 'package:deliveryapp/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key, required this.toggleView}) : super(key: key);
  final VoidCallback toggleView;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  String email = "";
  String password = "";
  String error = "";
  final _formKey = GlobalKey<FormState>();
  bool showPassword = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: const Text('Sign in to Brew Crew'),
              actions: [
                ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: widget.toggleView,
                  icon: Icon(Icons.person),
                  label: Text("Register"),
                )
              ],
            ),
            body: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: inputFieldDecoration.copyWith(
                        hintText: "Email",
                      ),
                      validator: (val) {
                        if (val!.isEmpty || val == null) {
                          return "Enter Email";
                        } else if (!val.contains("@")) {
                          return "Enter a valid Email";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      validator: (val) {
                        if (val!.isEmpty || val == null) {
                          return "Enter Password";
                        } else if (val.length < 6) {
                          return "Password should be greater than 6 characters";
                        } else {
                          return null;
                        }
                      },
                      decoration: inputFieldDecoration.copyWith(
                        hintText: "Password",
                        suffix: password.isEmpty
                            ? null
                            : IconButton(
                                constraints:
                                    BoxConstraints(maxWidth: 30, maxHeight: 30),
                                icon: showPassword
                                    ? const Icon(
                                        Icons.lock_open,
                                        color: Colors.pink,
                                      )
                                    : const Icon(
                                        Icons.lock_outline,
                                        color: Colors.pink,
                                      ),
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                              ),
                      ),
                      obscureText: showPassword,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.pink),
                        foregroundColor: MaterialStateProperty.all(
                          Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          dynamic result =
                              await _auth.signInWithEmailAndPassword(
                            email,
                            password,
                          );
                          if (result == null) {
                            setState(() {
                              _isLoading = false;
                              error = "Please supply a valid email";
                            });
                          }
                        }
                      },
                      child: Text(
                        "Sign in",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
