import 'dart:async';
import 'package:Lucky_or_Not/app_pages/verify_email_page.dart';
import 'package:Lucky_or_Not/components/log_in_button.dart';
import 'package:Lucky_or_Not/components/sign_up_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Timer? timer;

  bool check = false;

  late String password;
  bool active = false;

  String displayText = 'Enter the password';
  String displayCharacterCheckerText = '';

  double power = 0;

  String errorMessage = '';

  RegExp letterReg = RegExp(r"(?=.*[a-z])(?=.*[A-Z])");
  RegExp specialCharAndNumReg = RegExp(r"(?=.*\d)(?=.*\W)");

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void initState() {
    // TODO: implement initState
    super.initState();

    timer = Timer.periodic(Duration(
      seconds: 1 ,
    ),
            (_){
          setState(() {
            check = !check;
          });
        });
  }

  void validateEmail(String val) {
    String email = val.trim();
    if(email.isEmpty){
      setState(() {
        errorMessage = "Email can not be empty";
      });
    }else if(!EmailValidator.validate(val, false)){
      setState(() {
        errorMessage = "Invalid Email Address";
      });
    }else{
      setState(() {
        errorMessage = "";
      });
    }
  }
  void checkPassword(String val) {
    displayCharacterCheckerText =
    'Password should contain at least one special character,\n'
        'one lower case and one upper case letter and one number.';
    password = val.trim();
    if (password.isEmpty) {
      setState(() {
        power = 0;
        displayText = '';
      });
    }
    else if (password.length < 6) {
      setState(() {
        power = 1 / 4;
        displayText = 'Password is too short';
      });
    }
    else if (password.length < 9) {
      setState(() {
        power = 2 / 4;
        displayText = 'Password is acceptable but not too strong';
      });
    } else {
      if (password.length > 9 && letterReg.hasMatch(password)) {
        setState(() {
          power = 3 / 4;
          displayText = 'Your password is strong';
        });
        if (specialCharAndNumReg.hasMatch(password)) {
          setState(() {
            power = 1;
            displayText = 'Your password is too strong';
            displayCharacterCheckerText = '';
          });
        }
        else{
          return;
        }
      }
    }
  }
  void signUserUp() async {
    final user = FirebaseAuth.instance.currentUser;
    user == null ? showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator())) : null;
    try {
       await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());

       final uid = FirebaseAuth.instance.currentUser!.uid;
       sendUserInfo(emailController.text.trim(),uid);

       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
           builder: (context) => VerifyEmailPage()
       ),(Route<dynamic> rout) => false);

    }on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The account already exists for that email.')));
      }
      else{
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
            content: Text('An error has ocurred\n${e.toString()}')));
      }
    }
  }
  Future sendUserInfo(String text,String uid) async{
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'email': text.trim(),
      'highscore': 0
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 10),
                Container(
                  width: 150,
                  height: 150,
                  child:Image.asset('assets/images/upside_down_question_mark.png') ,
                ),
                SizedBox(height: 10),
                Text('Welcome to register page!',
                  style: TextStyle(fontSize: 18,
                      height: 2,
                      letterSpacing: 5,
                      fontStyle: FontStyle.italic)
               ),
                Text('Register now.'),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    controller: emailController,
                    onChanged: (val) => validateEmail(val),
                    obscureText: false,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'E-mail',
                        hintStyle: TextStyle(color: Colors.grey[500])
                    ),
                  ),
                ),
                SizedBox(height: 20,
                  child: Text(errorMessage,
                        style: TextStyle(color: Colors.red,
                          )
                        )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    controller: passwordController,
                    onChanged: (val) => checkPassword(val) ,
                    obscureText: true,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey[500])
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Text(displayCharacterCheckerText,
                style: TextStyle(color: Colors.black),),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: LinearProgressIndicator(
                    value: power,
                    backgroundColor: Colors.white,
                    color: power <= 1 / 4
                        ? Colors.red
                        : power == 2 / 4
                        ? Colors.yellow
                        : power == 3 / 4
                        ? Colors.blue
                        : Colors.green,
                    minHeight: 15,
                  ),
                ),
                SizedBox(height: 5),
                Text(displayText),
                SizedBox(height: 10),
                SignUpButton(signUserUp: signUserUp),
                SizedBox(height: 100,
                child: AnimatedPadding(
                    padding: check ? EdgeInsets.only(top: 50) : EdgeInsets.only(top:0),
                    child: Icon(Icons.thumb_down),
                    duration: Duration(seconds: 1))),
                Text('Already have an account?'),
                LoginButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
