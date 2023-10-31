part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {}

final class Authentication extends AuthenticationState {}

final class UnAuthentication extends AuthenticationState {}

final class AuthenticationLodingState extends AuthenticationState {}

final class AuthenticationErrorState extends AuthenticationState {
  final String errorMessage;

  AuthenticationErrorState({required this.errorMessage});
}
