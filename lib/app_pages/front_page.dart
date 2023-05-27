import 'dart:async';
import 'package:Lucky_or_Not/app_pages/verify_email_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../auth_pages/login_page.dart';

class frontPage extends StatefulWidget {
  const frontPage({Key? key}) : super(key: key);

  @override
  State<frontPage> createState() => _frontPageState();
}

class _frontPageState extends State<frontPage> {
  bool change = false;

  @override
   initState()  {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
         change = true;
      });
    });
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            if(FirebaseAuth.instance.currentUser == null){
              return LoginPage();
            }
            else{
              return VerifyEmailPage();
            }
          }
      ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 150),
            AnimatedPadding(
              padding: change ? EdgeInsets.only(top: 100) : EdgeInsets.only(top: 0),
              child: Icon(Icons.question_mark,
              size: 100 ),
              duration: Duration(seconds: 2),
              curve: Curves.bounceOut ,
            ),
          ],
        ),
      ),
    );
  }
}