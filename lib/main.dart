import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/screens/authenticate/SignUp.dart';
import 'package:todoapp/screens/authenticate/sign_in.dart';
import 'package:todoapp/screens/home/home.dart';
import 'package:todoapp/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todoapp/services/auth.dart';
import 'package:todoapp/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/services/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ListOfReminders.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
       MultiProvider(
         providers: [
          Provider<AuthenticationService>(
          create: (_)=> AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
        create: (context) =>  context.read<AuthenticationService>().authStateChanges,
        initialData: null,
        ),
      ],
        child:
        Builder(
          builder: (BuildContext context) {
            return
            MaterialApp(
              home: Wrapper(),
              routes: {
                '/SignIn': (_) => SignIn(),
                '/home': (_) => ListOfReminders(),
                '/SignUp': (_) => SignUp(),
              },

            );
          }
        ),
    );
  }
}
