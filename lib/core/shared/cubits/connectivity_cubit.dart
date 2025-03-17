import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/shared/cubits/connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final Connectivity _connectivity;
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  ConnectivityCubit(this._connectivity) : super(ConnectivityLoading()) {
    _monitorConnection();
  }

  void _monitorConnection() {
    _subscription = _connectivity.onConnectivityChanged.listen((result) {
      if (result.contains(ConnectivityResult.none)) {
        emit(ConnectivityDisconnected());
      } else {
        emit(ConnectivityConnected());
      }
    });
  }

  Future<void> checkConnection() async {
    emit(ConnectivityLoading());
    final result = await _connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.none)) {
      emit(ConnectivityDisconnected());
    } else {
      emit(ConnectivityConnected());
    }
  }

  bool isConnected() {
    final result = _connectivity.checkConnectivity();
    result.then((value) {
      if (value.contains(ConnectivityResult.none)) {
        return false;
      } else {
        return true;
      }
    });
    return false;
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
