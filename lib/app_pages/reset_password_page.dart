import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}


class _ResetPasswordPageState extends State<ResetPasswordPage> {

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  String errorMessage = '';

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reset Password'),
      backgroundColor: Colors.black,),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Enter your email to reset your password.',
                textScaleFactor: 1.5,),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
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
                    validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                        ? 'Enter a valid email'
                        : null,
                  ),
                ),
                Text(errorMessage),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  icon: Icon(Icons.email_outlined),
                    label: Text('Reset Password'),
                    onPressed: () => resetPassword() ,
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }

  resetPassword() async{
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.
          sendPasswordResetEmail(email: emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email sent')));
    Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error${e.toString()}')));
      Navigator.of(context).pop();
    }
  }
}
