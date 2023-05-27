import 'package:flutter/material.dart';

import '../app_pages/reset_password_page.dart';

class ForgotPasswordButton extends StatefulWidget {
  const ForgotPasswordButton({
    super.key,
  });

  @override
  State<ForgotPasswordButton> createState() => _ForgotPasswordButtonState();
}

class _ForgotPasswordButtonState extends State<ForgotPasswordButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text('Forgot Password?', style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.black,
          decoration: TextDecoration.underline,
          decorationColor: Colors.brown,
          decorationThickness: 1.5,
          fontStyle: FontStyle.italic
      ),
      ),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ResetPasswordPage())),
    );
  }
}