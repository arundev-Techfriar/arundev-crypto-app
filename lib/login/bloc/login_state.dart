part of 'login_bloc.dart';

abstract class LoginAuthenticationState extends Equatable {
  const LoginAuthenticationState();

  @override
  List<Object> get props => [];
}
///Login authentication initial state
class LoginAuthenticationInitial extends LoginAuthenticationState {}
///Checking login data
class LoginAuthenticationLoading extends LoginAuthenticationState {}
///when authentication is failure displays a failure message
class LoginAuthenticationFailiure extends LoginAuthenticationState {
  final String message;
  LoginAuthenticationFailiure({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
///Login authentication success state, gets user details
class LoginAuthenticationSuccess extends LoginAuthenticationState {
  final AuthenticationDetail authenticationDetail;
  LoginAuthenticationSuccess({
    required this.authenticationDetail,
  });
  @override
  List<Object> get props => [authenticationDetail];
}
