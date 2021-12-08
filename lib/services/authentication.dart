import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/main.dart';

class AuthenticationService{
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<String?> signIn ({required String email ,required String password })
  async {
    try{
       await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
       return "Signed In";
    }on FirebaseAuthException catch(e){
      return e.message;
    }

  }
  Future<String?> signUp ({required String email ,required String password })
  async {
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return 'Signed Up';

    }on FirebaseAuthException catch(e){
      return e.message;
    }

  }
  Future<String?> signOut ()
    async {
      await _firebaseAuth.signOut();
      return "Signed Out";
    }





}