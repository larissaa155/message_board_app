import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUser(String uid, String firstName, String lastName, String role) async {
    return await users.doc(uid).set({
      'first_name': firstName,
      'last_name': lastName,
      'role': role,
      'registered_at': Timestamp.now(),
    });
  }
}
