import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum InternetStates { Initial, Connected, Disconnected }

class InternetCubits extends Cubit<InternetStates> {
  Connectivity _connectivity = Connectivity();

  StreamSubscription? streamSubs;
  InternetCubits() : super(InternetStates.Initial) {
    streamSubs = _connectivity.onConnectivityChanged.listen(
      (result) {
        if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
          emit(InternetStates.Connected);
        } else {
          emit(InternetStates.Disconnected);
        }
      },
    );
  }
}
