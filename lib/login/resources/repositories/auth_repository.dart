import 'package:crypto_news_app/login/models/authentication_detail.dart';
import 'package:crypto_news_app/login/resources/services/auth_firebase_services.dart';
import 'package:crypto_news_app/login/resources/services/google_signIn_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository {
  final AuthFirebaseService _authenticationFirebaseProvider;
  final GoogleSignInService _googleSignInProvider;
  AuthenticationRepository(
      {required AuthFirebaseService authenticationFirebaseProvider,
      required GoogleSignInService googleSignInProvider})
      : _googleSignInProvider = googleSignInProvider,
        _authenticationFirebaseProvider = authenticationFirebaseProvider;

  ///Converting data types of user from firebase authentication and returns it
  Stream<AuthenticationDetail> getAuthDetailStream() {
    return _authenticationFirebaseProvider.getAuthStates().map((user) {
      return _getAuthCredentialFromFirebaseUser(user: user);
    });
  }

  ///Authenticating user with google when user clicks on login
  Future<AuthenticationDetail> authenticateWithGoogle() async {
    User? user = await _authenticationFirebaseProvider.login(
        credential: await _googleSignInProvider.login());
    return _getAuthCredentialFromFirebaseUser(user: user);
  }

  ///if the user is unauthenticated logs out the user from both firebase and google services
  Future<void> unAuthenticate() async {
    await _googleSignInProvider.logout();
    await _authenticationFirebaseProvider.logout();
  }

  ///if user is not null fills user details
  AuthenticationDetail _getAuthCredentialFromFirebaseUser(
      {required User? user}) {
    AuthenticationDetail authDetail;
    if (user != null) {
      authDetail = AuthenticationDetail(
        isValid: true,
        uid: user.uid,
        email: user.email,
        photoUrl: user.photoURL,
        name: user.displayName,
      );
    } else {
      authDetail = AuthenticationDetail(isValid: false);
    }
    return authDetail;
  }
}
