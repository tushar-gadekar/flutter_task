import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  Stream<bool> get onConnectivityChanged => Connectivity()
      .onConnectivityChanged
      .map((result) => result != ConnectivityResult.none);

  Future<bool> isConnected() async {
    var result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }
}