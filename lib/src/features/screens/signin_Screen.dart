import 'package:weather_app/src/features/bloc/blocs/signIn_bloc.dart';
import 'package:weather_app/src/features/bloc/events/signIn_events.dart';
import 'package:weather_app/src/features/bloc/states/signIn_states.dart';
import 'package:weather_app/src/features/screens/home_Screen.dart';
import 'package:weather_app/src/features/screens/search_city_weather_screen.dart';
import 'package:weather_app/src/features/screens/tab_bar.dart';
import 'package:weather_app/src/features/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('SignIn'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocConsumer<SignInBloc, SignInStates>(listener: (context, state) {
                if (state is SignedInState) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => TabNavigationBar()));
                } else if (state is SignOutstate) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => WelcomeScreen()));
                }
                // TODO: implement listener
              }, builder: (context, state) {
                if (state is SignInErrorState) {
                  return Text(
                    state.error,
                    style: TextStyle(color: Colors.red),
                  );
                } else {
                  return Text('');
                }
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _email,
                  onChanged: ((value) {
                    BlocProvider.of<SignInBloc>(context)
                        .add(SignInOnchangeEvent(email: _email.text, password: _password.text));
                  }),
                  decoration: InputDecoration(hintText: 'Email'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: _password,
                  onChanged: ((value) {
                    BlocProvider.of<SignInBloc>(context)
                        .add(SignInOnchangeEvent(email: _email.text, password: _password.text));
                  }),
                  decoration: InputDecoration(hintText: 'password'),
                ),
              ),
              BlocBuilder<SignInBloc, SignInStates>(
                builder: (context, state) {
                  return state is SignInLoadingState
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : CupertinoButton(
                          child: Text('Create a User'),
                          onPressed: () {
                            if (state is SignInValidState) {
                              BlocProvider.of<SignInBloc>(context)
                                  .add(SignInSubmittedEvent(email: _email.text, password: _password.text));

                              BlocProvider.of<SignInBloc>(context).signUp(_email.text, _password.text).then((res) {
                                if (res != null) {
                                  BlocProvider.of<SignInBloc>(context).add(SignedUpEvent());
                                }
                              });
                              ;
                            }
                          },
                          color: state is SignedInState ? Colors.red : Colors.grey,
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
