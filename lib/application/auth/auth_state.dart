part of 'auth_bloc.dart';

abstract class AuthState {}
class AuthInitialState extends AuthState {}
class AuthLoadingState extends AuthState {}
class AuthenticatedState extends AuthState {
  final String email;
  AuthenticatedState(this.email);
}
class UnAuthenticatedState extends AuthState {}
class AuthErrorState extends AuthState {
  final String msg;
  AuthErrorState(this.msg);
}