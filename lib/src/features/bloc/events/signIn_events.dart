import 'package:firebase_auth/firebase_auth.dart';

abstract class SignInEvent {}

class SignInSubmittedEvent extends SignInEvent {
  final String email;
  final String password;

  SignInSubmittedEvent({required this.email, required this.password});
}

class SignedUpEvent extends SignInEvent {}

class SignOutEvent extends SignInEvent {}

class SignInOnchangeEvent extends SignInEvent {
  final String email;
  final String password;

  SignInOnchangeEvent({required this.email, required this.password});
}
