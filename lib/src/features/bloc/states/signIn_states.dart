abstract class SignInStates {}

class SignInInintialState extends SignInStates {}

class SignInErrorState extends SignInStates {
  final String error;
  SignInErrorState(this.error);
}

class SignInValidState extends SignInStates {}

class SignInOnchangedState extends SignInStates {}

class SignInLoadingState extends SignInStates {}

class SignedInState extends SignInStates {}

class SignOutstate extends SignInStates {}
