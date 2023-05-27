import 'package:flutter/material.dart';
import '../auth_pages/register_page.dart';


class RegisterButton extends StatefulWidget {
  const RegisterButton({
    super.key,
  });

  @override
  State<RegisterButton> createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<RegisterButton> {
  void navigateRegisterPage(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => RegisterPage()));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: navigateRegisterPage,
      child: Container(
        child: Text('Register now',
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