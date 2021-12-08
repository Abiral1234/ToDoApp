import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/models/user.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  get authStateChanges => null;

      //create user obj based on FirebaseUser
      TheUser? _userFromFirebaseUser(User user){

        // ignore: unnecessary_null_comparison
        return user != null ? TheUser(uid: user.uid) : null;
      }
      //auth change user stream
      Stream<TheUser?> get user{
        return _auth.authStateChanges()
            .map((User? user) => _userFromFirebaseUser(user!));
      }
      // every time a user signs in or signs out we get the event down the stream

      //Sign In Anon
      Future signInAnon() async{
        try{
          UserCredential result = await _auth.signInAnonymously();
          User? user = result.user;
          return _userFromFirebaseUser(user!);
        }
        catch(e){
          print(e.toString());
          print('Authentication error');
          return null;
        }

      }

      //Sign in With Email

      //register with email and password

      //Sign Out
}