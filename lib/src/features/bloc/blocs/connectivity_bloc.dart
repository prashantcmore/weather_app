import 'dart:async';

import 'package:weather_app/src/features/bloc/states/connectivity_states.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity/connectivity.dart';

import '../events/connectivity_event.dart';

class ConnectionBloc extends Bloc<ConnectionEvent, ConnectionStat> {
  Connectivity _connectivity = Connectivity();
  StreamSubscription? _connectivitySubs;

  ConnectionBloc() : super(InitialState()) {
    on<ConnectedEvent>(((event, emit) => emit(ConnectedState())));
    on<DisConnectedEvent>((event, emit) => emit(DisConnectedState()));
    _connectivitySubs = _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
        add(ConnectedEvent());
      } else {
        add(DisConnectedEvent());
      }
    });
  }

  void canel() {
    _connectivitySubs!.cancel();
  }
}
