import 'package:deliveryapp/services/auth.dart';
import 'package:deliveryapp/shared/constants.dart';
import 'package:deliveryapp/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final VoidCallback toggleView;
  const Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = new GlobalKey<FormState>();
  String email = "";
  String password = "";
  String error = "";
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
              title: const Text('Register to Brew Crew'),
              actions: [
                ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: widget.toggleView,
                  icon: Icon(Icons.person),
                  label: Text("Sign In"),
                ),
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
                      decoration: inputFieldDecoration.copyWith(
                        hintText: "Password",
                      ),
                      validator: (val) {
                        if (val!.isEmpty || val == null) {
                          return "Enter Password";
                        } else if (val.length < 6) {
                          return "Password should be greater than 6 characters";
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
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
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              _isLoading = false;
                              error = "Please supply a valid email";
                            });
                          }
                        }
                      },
                      child: const Text(
                        "Register",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
    ;
  }
}
