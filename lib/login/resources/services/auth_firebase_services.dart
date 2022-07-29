import 'package:firebase_auth/firebase_auth.dart';

///User authentication service using firebase_auth package
class AuthFirebaseService {
  final FirebaseAuth _firebaseAuth;
  AuthFirebaseService({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  ///returns stream of users depending on the state changes in authentication, only if the user is logged in
  Stream<User?> getAuthStates() {
    return _firebaseAuth.authStateChanges();
  }

  ///authenticates the user with credential and signs in and returns the UserCredentials
  Future<User?> login({
    required AuthCredential credential,
  }) async {
    UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);
    return userCredential.user;
  }

  ///Log user out from the firebase auth
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
