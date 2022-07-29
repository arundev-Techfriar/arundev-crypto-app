import 'package:crypto_news_app/home/resources/crypto_network_service.dart';
import 'package:crypto_news_app/home/views/home_screen.dart';
import 'package:crypto_news_app/login/bloc/login_bloc.dart';
import 'package:crypto_news_app/login/resources/repositories/auth_repository.dart';
import 'package:crypto_news_app/login/resources/services/auth_firebase_services.dart';
import 'package:crypto_news_app/login/resources/services/google_signIn_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  ///To initialize the firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(CryptoNewsApp());
}

class CryptoNewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///any widget created can return the LoginAuthenticationBloc
    return BlocProvider(
      create: (context) => LoginAuthenticationBloc(
        authenticationRepository: AuthenticationRepository(
          authenticationFirebaseProvider: AuthFirebaseService(
            firebaseAuth: FirebaseAuth.instance,
          ),
          googleSignInProvider: GoogleSignInService(
            googleSignIn: GoogleSignIn(),
          ),
        ),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Crypto News',
        theme: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.black,
          ),
          scaffoldBackgroundColor: Colors.black,
        ),
        home: MultiRepositoryProvider(
          ///user will directly go to home screen if user is logged in
          child: HomeScreen(),
          providers: [
            ///provides CryptoNewsService to HomeScreen
            RepositoryProvider(
              create: (context) => CryptoNewsService(),
            ),
          ],
        ),
      ),
    );
  }
}
