import 'package:crypto_news_app/login/views/widget/login_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Builder(
          builder: (context) {
            ///returning the widget login_auth
            return LoginAuth(runtimeType: runtimeType);
          },
        ),
      ),
    );
  }
}
