import 'package:flutter/material.dart';


class GoogleSignInGesture extends StatelessWidget {
  GoogleSignInGesture({
    super.key,required this.onTap
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white
          ),
          height:50,
          width:50,
          child: Image.asset('assets/images/google_logo.png')
      ),
    );
  }
}