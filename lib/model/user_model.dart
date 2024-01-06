import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? email;
  String? username;
  String? lokasi;
  String? profileImageUrl; // Add this property

  UserModel({
    this.uid,
    this.email,
    this.username,
    this.lokasi,
    this.profileImageUrl,
  });

  // data dari server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      username: map['username'],
      lokasi: map['lokasi'],
      profileImageUrl: map['profileImageUrl'], // Include profileImageUrl
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'lokasi': lokasi,
      'profileImageUrl': profileImageUrl, // Include profileImageUrl
    };
  }

  // Untuk update server Lokasi Customer
  Future<void> updateAddress(String newAddress) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');

    try {
      await users.doc(uid).update({'address': newAddress});
    } catch (e) {
      print("Error updating address: $e");
    }
  }

  // Dapatkan data pengguna dari Firestore berdasarkan UID
  static Future<UserModel?> getUserFromFirestore(String uid) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (snapshot.exists) {
        return UserModel.fromMap(snapshot.data());
      } else {
        return null;
      }
    } catch (e) {
      print("Error getting user data: $e");
      return null;
    }
  }
}
