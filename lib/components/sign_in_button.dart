
import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
   SignInButton({
    super.key,required this.signUserIn
  });

  final void Function()? signUserIn;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: signUserIn ,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black
        )  ,
        width:100,
        height: 35,
        child: Center(
          child: Text('Sign In',
          style: TextStyle(
            color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}