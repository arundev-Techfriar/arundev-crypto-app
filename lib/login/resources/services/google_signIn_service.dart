import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

///Google sign in authentication using google_sign_in and firebase_auth package
class GoogleSignInService {
  final GoogleSignIn _googleSignIn;
  GoogleSignInService({
    required GoogleSignIn googleSignIn,
  }) : _googleSignIn = googleSignIn;

  ///Login method
  Future<AuthCredential> login() async {
    ///uses the google_sign_in package and creates a google sign in account
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

    ///creates google sign in authentication using google sign in account
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    ///creates authentication credential using GoogleAuthProvider from google_sign_in package
    AuthCredential authCredential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    return authCredential;
  }

  ///LogOut user from the google
  Future<void> logout() async {
    if (await _googleSignIn.isSignedIn()) {
      _googleSignIn.signOut();
    }
  }
}
