part of 'login_bloc.dart';

abstract class LoginAuthenticationEvent extends Equatable {
  const LoginAuthenticationEvent();

  @override
  List<Object> get props => [];
}

///when application starts, event checks for authentication details
class LoginAuthenticationStarted extends LoginAuthenticationEvent {}

///State changed event, if user is logged out  event changes when user logged in
class LoginAuthenticationStateChanged extends LoginAuthenticationEvent {
  final AuthenticationDetail authenticationDetail;
  LoginAuthenticationStateChanged({
    required this.authenticationDetail,
  });
  @override
  List<Object> get props => [authenticationDetail];
}

///event triggered when user clicks on login with google button
class LoginAuthenticationGoogleStarted extends LoginAuthenticationEvent {}

///event triggered when user clicks on the logout button
class LoginAuthenticationExited extends LoginAuthenticationEvent {}
