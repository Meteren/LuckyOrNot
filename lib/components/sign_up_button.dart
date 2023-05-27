
import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
   SignUpButton({
    super.key,required this.signUserUp
  });

  final void Function()? signUserUp;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: signUserUp ,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black
        )  ,
        width:100,
        height: 35,
        child: Center(
          child: Text('Sign Up',
          style: TextStyle(
            color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}