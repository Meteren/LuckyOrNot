import 'package:Lucky_or_Not/app_pages/main_page.dart';
import 'package:Lucky_or_Not/app_pages/verify_email_page.dart';
import 'package:Lucky_or_Not/components/build_pages_function.dart';
import 'package:Lucky_or_Not/components/sign_in_button.dart';
import 'package:Lucky_or_Not/sign_in_methods/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/forgot_password_button.dart';
import '../components/google_sign_in_button.dart';
import '../components/register_button.dart';
import '../components/text_field.dart';

class LoginPage extends StatefulWidget {

  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String errorMessage = '';

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  Future sendUserInfo(String text,String uid) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'email': text.trim(),
      'highscore': 0
    });
  }

  void signUserInWithEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      user == null ? showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(child: CircularProgressIndicator())) : null;
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (context) => FirebaseAuth.instance.currentUser!.emailVerified ? buildPages(context)
              : VerifyEmailPage()
      ),(Route<dynamic> rout) => false);
    } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          Navigator.of(context).pop();
          wrongPassword();
        } else if (e.code == 'email-already-in-use') {
          Navigator.of(context).pop();
          emailInUse();
        } else if (e.code == 'user-not-found') {
          Navigator.of(context).pop();
          wrongEmail();
      }
        else{
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Something went wrong:${e.toString()}')));
        }
    }
  }
  Future<void> SignInWithGoogle() async {
    try {
      await signInWithGoogle();

      sendUserInfo(FirebaseAuth.instance.currentUser!.email!,
      FirebaseAuth.instance.currentUser!.uid);

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MainPage()
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('An error has occured while signing in.\n'
              '${e.toString()}'),
      duration: Duration(seconds: 60),));
    }
  }
  void wrongPassword() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Wrong Password!'),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void wrongEmail() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Wrong E-mail!'),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void emailInUse() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('E-mail is already in use!'),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void validateEmail(String val) {
    if(val.isEmpty){
      setState(() {
        errorMessage = "Email can not be empty";
      });
    }else if(!EmailValidator.validate(val, true)){
      setState(() {
        errorMessage = "Invalid Email Address";
      });
    }else{
      setState(() {
        errorMessage = "";
      });
    }
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
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  width: 150,
                  height: 150,
                  child: Image.asset('assets/images/question_mark.jpg'),
                ),
                Text('Welcome back!',
                    style: TextStyle(fontSize: 18,
                        height: 2,
                        letterSpacing: 5,
                        fontStyle: FontStyle.italic)
                ),
                SizedBox(
                    height: 50,
                    child: Center(child: Text(
                        'Please sign-in using your e-mail and password.'))
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'E-mail',
                        hintStyle: TextStyle(color: Colors.grey[500])
                    ),
                    onChanged: (val){
                      validateEmail(val);
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ForgotPasswordButton(),
                    ],
                  ),
                ),
                SignInButton(signUserIn:signUserInWithEmail),
                SizedBox(
                    height: 30,
                    child: Center(child: Text(errorMessage,
                    style: TextStyle(color: Colors.red))),
                    ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Text('Or Sign In With',
                      textScaleFactor: 1,),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                GoogleSignInGesture(onTap: SignInWithGoogle),
                SizedBox(height: 30),
                Text('Don\'t have an account?'),
                RegisterButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}




