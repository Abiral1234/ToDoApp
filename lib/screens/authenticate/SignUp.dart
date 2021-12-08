import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todoapp/screens/home/home.dart';
import 'package:todoapp/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/services/authentication.dart';
import '../../services/authentication.dart';
import 'package:provider/provider.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late final String username;
  late final String email;
  late final String password;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

    FirebaseAuth auth = FirebaseAuth.instance;
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    FirebaseFirestore firestore =FirebaseFirestore.instance;
    CollectionReference SignedUser = FirebaseFirestore.instance.collection('SignedUser');
//    DocumentReference email = FirebaseFirestore.instance.collection('SignedUser').doc;

    Future<DocumentReference> addUser() async {
      return SignedUser.add({
        'username': username,
        'email': email,
        'password':password,
      });

    }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,

      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60,),
            Text('Welcome',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text('Create An Account',style: TextStyle(fontSize: 15),),
            SizedBox(height: 20,),
            TextField(

              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Username',
                hintStyle: TextStyle(fontSize: 20),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 15),
              ),
              onSubmitted: (value){
                setState(() {
                  username =value;
                });
              },
            ),
            SizedBox(height: 20,),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Email',
                hintStyle: TextStyle(fontSize: 20),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 15),
              ),
              onSubmitted: (value){
                setState(() {
                  email =value;
                });
              },
            ),
            SizedBox(height: 20,),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Password',
                hintStyle: TextStyle(fontSize: 20),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 15),
              ),
              onSubmitted: (value){
                setState(() {
                  password =value;
                });
              },
            ),
            SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Confirm Password',
                hintStyle: TextStyle(fontSize: 20),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 15),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                ElevatedButton(

                    onPressed: () {
                      addUser();
                      context.read<AuthenticationService>().signUp(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                      );

                        Navigator.of(context).pushNamed('/SignIn');

                      //dynamic result = await _auth.signInAnon();
                      //if(result==null){
                      //  print('Error Signing in');
                      //}
                      //else{
                      //  print('Sign in');
                      //  print(result.uid);
                      //}
                    },

                    child: Text('Sign Up',style: TextStyle(fontSize: 20),),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13.0),)))
                ),
                SizedBox(height: 10,),
                Text('  Already have an account ?',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushNamed('/SignIn');
                    },
                    child: Text('Sign In', style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.blue),)
                ),

              ],
            ),

          ],),

      ) ,
    );
  }
}
