import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../model/user_model.dart';
import '../services/connectivity_services.dart';
import '../services/firebase_services.dart';
import '../services/localdb_service.dart';

class UserProvider with ChangeNotifier {
  final FirebaseService _firebase = FirebaseService();
  final LocalDBService _local = LocalDBService();
  final ConnectivityService _connectivity = ConnectivityService();

  List<UserModel> users = [];

  Future<void> initialize() async {
    await _loadUsers();
    _connectivity.onConnectivityChanged.listen((
      connected) {
      if (connected) syncLocalToFirebase();

    });
    
  }

  Future<void> _loadUsers() async {
    if (await _connectivity.isConnected()) {
      users = await _firebase.fetchUsers();
      await _local.deleteAll();
    } else {
      users = await _local.getUsers();
    }
    notifyListeners();
  }

  Future<void> addUser(UserModel user) async {
    if (await _connectivity.isConnected()) {
      await _firebase.addUser(user);
    } else {
      user.id = const Uuid().v4();
      await _local.insertUser(user);
    }
    await _loadUsers();
  }

  Future<void> syncLocalToFirebase() async {
    final localUsers = await _local.getUsers();
    for (var user in localUsers) {
      await _firebase.addUser(user);
    }
    await _local.deleteAll();
    await _loadUsers();
  }
}