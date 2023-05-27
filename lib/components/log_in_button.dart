
import 'package:flutter/material.dart';

import '../auth_pages/login_page.dart';

class LoginButton extends StatefulWidget {
   LoginButton({
    super.key,
  });

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  void navigateLoginPage(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: navigateLoginPage,
      child: Container(
        child: Text('Login now',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black,
              decoration: TextDecoration.underline,
              decorationColor: Colors.brown,
              decorationThickness: 1.5,
              fontStyle: FontStyle.italic
          ),
        ),
      ),
    );
  }
}