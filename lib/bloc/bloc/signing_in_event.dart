part of 'signing_in_bloc.dart';

@immutable
sealed class SigningInEvent {}

class SignIn extends SigningInEvent {
  final String email;
  final String password;

  SignIn(this.email, this.password);
}

class Register extends SigningInEvent {
  final String email;
  final String password;

  Register(this.email, this.password);
}

class Fetching extends SigningInEvent {}

class SignOut extends SigningInEvent {}
