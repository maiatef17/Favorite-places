part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

class SignInEvent extends AuthenticationEvent {
  final String email, password;

  SignInEvent({required this.email, required this.password});
}

class SignUpEvent extends AuthenticationEvent {
  final String email, password;

  SignUpEvent({required this.email, required this.password});
}

class SignOutEvent extends AuthenticationEvent {}

class IsSignedInEvent extends AuthenticationEvent {}
