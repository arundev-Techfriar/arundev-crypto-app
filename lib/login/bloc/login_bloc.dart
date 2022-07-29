import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_news_app/login/models/authentication_detail.dart';
import 'package:crypto_news_app/login/resources/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginAuthenticationBloc
    extends Bloc<LoginAuthenticationEvent, LoginAuthenticationState> {
  final AuthenticationRepository _authenticationRepository;

  LoginAuthenticationBloc(
      {required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(LoginAuthenticationInitial());

  ///create stream subscription
  StreamSubscription<AuthenticationDetail>? authStreamSub;

  @override

  ///creates a close function to prevent data leak issue from stream subscription
  Future<void> close() {
    authStreamSub?.cancel();
    return super.close();
  }

  @override
  Stream<LoginAuthenticationState> mapEventToState(
    LoginAuthenticationEvent event,
  ) async* {
    if (event is LoginAuthenticationStarted) {
      try {
        ///return LoginAuthenticationLoading
        emit(LoginAuthenticationLoading());

        ///assigns stream subscription to authenticationRepository
        authStreamSub = _authenticationRepository
            .getAuthDetailStream()
            .listen((authDetail) {
          add(LoginAuthenticationStateChanged(
              authenticationDetail: authDetail));
        });
      } catch (error) {
        ///when user authentication is failed
        emit(LoginAuthenticationFailiure(
            message: 'Error occurred while fetching auth detail'));
      }
    } else if (event is LoginAuthenticationStateChanged) {
      if (event.authenticationDetail.isValid!) {
        ///if LoginAuthenticationStateChanged looks for isValid=true and redirect user to home Screen
        emit(LoginAuthenticationSuccess(
            authenticationDetail: event.authenticationDetail));
      } else {
        ///if LoginAuthenticationStateChanged looks for isValid=false and redirect user to login Screen
        emit(LoginAuthenticationFailiure(message: 'User has logged out'));
      }
    } else if (event is LoginAuthenticationGoogleStarted) {
      try {
        ///authenticating with google
        emit(LoginAuthenticationLoading());
        AuthenticationDetail authenticationDetail =
            await _authenticationRepository.authenticateWithGoogle();

        if (authenticationDetail.isValid!) {
          emit(LoginAuthenticationSuccess(
              authenticationDetail: authenticationDetail));
        } else {
          emit(LoginAuthenticationFailiure(message: 'User details not found.'));
        }
      } catch (error) {
        emit(LoginAuthenticationFailiure(
          message: 'Unable to login with Google. Try again.',
        ));
      }
    } else if (event is LoginAuthenticationExited) {
      try {
        ///Logout
        emit(LoginAuthenticationLoading());
        await _authenticationRepository.unAuthenticate();
      } catch (error) {
        emit(LoginAuthenticationFailiure(
            message: 'Unable to logout. Please try again.'));
      }
    }
  }
}