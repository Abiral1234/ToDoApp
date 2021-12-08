import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/screens/authenticate/authenticate.dart';
import 'package:todoapp/screens/home/home.dart';
import 'package:todoapp/models/user.dart';
import '../ListOfReminders.dart';
import 'authenticate/sign_in.dart';
import '../main.dart';

class Wrapper extends StatelessWidget {
  String? email;
  @override
  Widget build(BuildContext context) {

    final firebaseUser = context.watch<User?>();
    if(firebaseUser != null){
      //print('The user is :${firebaseUser.email}');
      email = firebaseUser.email;
      return ListOfReminders();

    }
    return SignIn();

  }
}
