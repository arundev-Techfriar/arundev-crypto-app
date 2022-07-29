import 'package:crypto_news_app/home/resources/crypto_network_service.dart';
import 'package:crypto_news_app/home/views/home_screen.dart';
import 'package:crypto_news_app/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginAuth extends StatelessWidget {
  const LoginAuth({
    Key? key,
    required this.runtimeType,
  }) : super(key: key);

  final Type runtimeType;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginAuthenticationBloc, LoginAuthenticationState>(
      listener: (context, state) {
        if (state is LoginAuthenticationSuccess) {
          ///if login authentication is successful navigating to home screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MultiRepositoryProvider(
                child: HomeScreen(),
                providers: [
                  RepositoryProvider(
                    create: (context) => CryptoNewsService(),
                  ),
                ],
              ),
            ),
          );
        } else if (state is LoginAuthenticationFailiure) {
          ///when login authentication is failure message is shown
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      buildWhen: (current, next) {
        if (next is LoginAuthenticationSuccess) {
          return false;
        }
        return true;
      },
      builder: (context, state) {
        ///Login page text and login button
        if (state is LoginAuthenticationInitial ||
            state is LoginAuthenticationFailiure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'CRYPTO',
                  style: TextStyle(
                      color: Color(0xffff9933),
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  'PANIC',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: 30,
                ),

                ///google sign in button using sign_in_button package
                SignInButton(
                  Buttons.Google,
                  onPressed: () =>
                      BlocProvider.of<LoginAuthenticationBloc>(context).add(
                    LoginAuthenticationGoogleStarted(),
                  ),
                ),
              ],
            ),
          );
        } else if (state is LoginAuthenticationLoading) {
          ///authenticating user with google
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
        }
        return Center(child: Text(''));
      },
    );
  }
}
