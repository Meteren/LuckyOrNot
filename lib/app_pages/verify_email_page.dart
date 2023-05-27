import 'dart:async';
import 'package:Lucky_or_Not/sign_in_methods/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../auth_pages/login_page.dart';
import '../components/build_pages_function.dart';


class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage ({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;

  Timer? timer;

  bool active = false;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      if (!isEmailVerified) {
        sendVerificationEmail();
        timer = Timer.periodic(Duration(
          seconds: 3,
        ),
                (_) => checkEmailVerified());
      }
  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  Future checkEmailVerified() async{

    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    });

    if(isEmailVerified) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('E-mail successfully verified')));
      timer?.cancel();
    }
  }

  Future sendVerificationEmail() async{
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() {
        active = false;
      });
      await Future.delayed(const Duration(seconds: 40), (){
        setState(() {
          active = true;
        });
      });
    }catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) => isEmailVerified ? buildPages(context)
  : Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Center(child: Text('Verify Email')),
      ) ,
      body: Center(
        child: Column(
          children: [
            SizedBox(height:30 ,),
            Text('Email verification is in progress...',
            textScaleFactor: 1.5,),
            SizedBox(height: 15,),
            CircularProgressIndicator(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: active ? sendVerificationEmail :
                    null,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: Text('Resend')),
                SizedBox(width: 10,),
                ElevatedButton(onPressed: (){
                  signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                    return LoginPage();
                  }));
                },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: Text('Cancel'))
              ],
            ),
          ],
        ),
      ),
      );
}
