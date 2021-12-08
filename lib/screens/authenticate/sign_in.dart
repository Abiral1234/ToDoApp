import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todoapp/screens/home/home.dart';
import 'package:todoapp/services/auth.dart';
import 'package:todoapp/services/authentication.dart';
import '../../services/authentication.dart';
import 'package:provider/provider.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60,),
                  Text('Welcome',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Text('Sign In to Continue',style: TextStyle(fontSize: 20),),
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
                  ),
                  SizedBox(height: 20,),

                ElevatedButton(
                    onPressed: () {
                      //dynamic allow =
                      context.read<AuthenticationService>().signIn(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                      Navigator.of(context).pushNamed('/home');
                     // print('Output is : $allow');
                    //dynamic result = await _auth.signInAnon();
                      //if(result==null){
                      //  print('Error Signing in');
                      //}
                      //else{
                      //  print('Sign in');
                      //  print(result.uid);
                      //}
                    },

                    child: Text('Sign In',style: TextStyle(fontSize: 20),),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13.0),)))
                ),
                  SizedBox(height: 10,),
                  GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushNamed('/SignUp');
                      },
                      child: Center(child: Text('    OR \n Sign Up', style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.blue),))
                  ),


                ],),

          ),
        ],
      ) ,
    );
  }
}
