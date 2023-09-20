import 'package:weather_app/src/features/bloc/events/signIn_events.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../states/signIn_states.dart';

class SignInBloc extends Bloc<SignInEvent, SignInStates> {
  final _auth = FirebaseAuth.instance;

  SignInBloc() : super(SignInInintialState()) {
    if (_auth.currentUser != null) {
      emit(SignedInState());
    } else {
      emit(SignInInintialState());
    }

    on<SignInOnchangeEvent>((event, emit) {
      if (EmailValidator.validate(event.email) == false) {
        return emit(SignInErrorState('Please enter a valid email'));
      } else if (event.password.length < 8) {
        return emit(SignInErrorState('Please enter a valid password'));
      } else {
        emit(SignInValidState());
      }
    });

    on<SignedUpEvent>(
      (event, emit) {
        emit(SignedInState());
      },
    );
    on<SignOutEvent>((event, emit) {
      emit(SignOutstate());
    });

    on<SignInSubmittedEvent>((event, emit) {
      emit(SignInLoadingState());
    });
  }
  dynamic signUp(String email, String pass) async {
    UserCredential res = await _auth.createUserWithEmailAndPassword(email: email, password: pass);

    final id = res.user!.uid;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('Token', id);

    if (res.user!.displayName != null) {
      add(SignedUpEvent());
    }
    return res;
  }

  void logout() {
    var logout = _auth.signOut();
    emit(SignOutstate());
  }

  login(String email, String password) {
    var logout = _auth.signInWithEmailAndPassword(email: email, password: password);
    add(SignedUpEvent());
  }
}
