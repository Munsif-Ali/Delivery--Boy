import 'package:deliveryapp/screens/authentication/authenticate.dart';
import 'package:deliveryapp/services/auth.dart';
import 'package:flutter/material.dart';
import "../screens/home/home.dart";

import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().user,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return Home();
        }
        return Authenticate();
      },
    );

    // final user = Provider.of<User?>(context);
    // if (user == null) {
    //   return Authenticate();
    // } else {
    //   return Home();
    // }
  }
}
