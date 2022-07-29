import 'package:crypto_news_app/home/bloc/crypto_bloc.dart';
import 'package:crypto_news_app/home/resources/crypto_network_service.dart';
import 'package:crypto_news_app/home/views/widget/crypto_news.dart';
import 'package:crypto_news_app/home/views/widget/user_details.dart';
import 'package:crypto_news_app/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///Bloc provider provides CryptoBloc and add LoadCryptoApi event
    return BlocProvider(
      create: (context) => CryptoBloc(
        RepositoryProvider.of<CryptoNewsService>(context),
      )..add(LoadCryptoApiEvent()),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('CRYPTO News'),
            actions: [
              ///displaying user details from user_details widget
              UserDetails(runtimeType: runtimeType),

              ///LogOut button on press navigates to login screen
              IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Color(0xFFFF9933),
                ),
                onPressed: () =>
                    BlocProvider.of<LoginAuthenticationBloc>(context).add(
                  LoginAuthenticationExited(),
                ),
              ),
            ],
          ),

          ///Displays news titles from crypto_news widget
          body: CryptoNews(),
        ),
      ),
    );
  }
}
