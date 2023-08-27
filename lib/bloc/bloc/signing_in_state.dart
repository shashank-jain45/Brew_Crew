part of 'signing_in_bloc.dart';

@immutable
sealed class SigningInState {}

final class SigningInInitial extends SigningInState {}

final class NotSignedIn extends SigningInState {}

final class SignedIn extends SigningInState {
  final String? userId;
  SignedIn({
    required this.userId,
  });
}

final class Loading extends SigningInState {}

final class ErrorSigningIn extends SigningInState {}

final class ErrorRegisteringIn extends SigningInState {}
