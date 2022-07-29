import 'package:crypto_news_app/login/bloc/login_bloc.dart';
import 'package:crypto_news_app/login/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({
    Key? key,
    required this.runtimeType,
  }) : super(key: key);

  final Type runtimeType;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginAuthenticationBloc, LoginAuthenticationState>(
      listener: (context, state) {
        ///when login authentication fails navigates to login page
        if (state is LoginAuthenticationFailiure) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      },
      builder: (context, state) {
        ///checks conditions for login_state
        if (state is LoginAuthenticationInitial) {
          BlocProvider.of<LoginAuthenticationBloc>(context)
              .add(LoginAuthenticationStarted());
          return CircularProgressIndicator();
        } else if (state is LoginAuthenticationLoading) {
          return CircularProgressIndicator();
        } else if (state is LoginAuthenticationSuccess) {
          return Row(
            children: [
              ///Displays user profile image
              CircleAvatar(
                backgroundImage:
                    Image.network('${state.authenticationDetail.photoUrl}')
                        .image,
                radius: 15,
              ),
              SizedBox(
                width: 5,
              ),

              ///Displays user profile name
              Text('${state.authenticationDetail.name}'),
            ],
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
