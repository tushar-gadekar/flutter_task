import '../model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference _ref = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(UserModel user) => _ref.add(user.toMap());

  Future<List<UserModel>> fetchUsers() async {
    var snapshot = await _ref.get();
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return UserModel.fromMap(data)..id = doc.id;
    }).toList();
  }
}