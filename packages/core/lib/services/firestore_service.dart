import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection reference untuk users
  static CollectionReference<Map<String, dynamic>> get _usersCollection =>
      _firestore.collection('users');

  // Simpan user data ke Firestore
  static Future<bool> saveUserData(UserModel userModel) async {
    try {
      await _usersCollection.doc(userModel.uid).set(userModel.toMap());
      return true;
    } catch (e) {
      log('Error saving user data: $e');
      return false;
    }
  }

  // Update user data di Firestore
  static Future<bool> updateUserData(
    String uid,
    Map<String, dynamic> data,
  ) async {
    try {
      // Tambahkan timestamp update
      data['updatedAt'] = Timestamp.now();

      await _usersCollection.doc(uid).update(data);
      return true;
    } catch (e) {
      log('Error updating user data: $e');
      return false;
    }
  }

  // Ambil user data dari Firestore
  static Future<UserModel?> getUserData(String uid) async {
    try {
      final doc = await _usersCollection.doc(uid).get();

      if (doc.exists && doc.data() != null) {
        return UserModel.fromMap(doc.data()!);
      }

      return null;
    } catch (e) {
      log('Error getting user data: $e');
      return null;
    }
  }

  // Stream user data (real-time updates)
  static Stream<UserModel?> streamUserData(String uid) {
    return _usersCollection.doc(uid).snapshots().map((doc) {
      if (doc.exists && doc.data() != null) {
        return UserModel.fromMap(doc.data()!);
      }
      return null;
    });
  }

  // Hapus user data dari Firestore
  static Future<bool> deleteUserData(String uid) async {
    try {
      await _usersCollection.doc(uid).delete();
      return true;
    } catch (e) {
      log('Error deleting user data: $e');
      return false;
    }
  }

  // Check apakah user sudah ada di Firestore
  static Future<bool> userExists(String uid) async {
    try {
      final doc = await _usersCollection.doc(uid).get();
      return doc.exists;
    } catch (e) {
      log('Error checking user existence: $e');
      return false;
    }
  }

  // Buat atau update user data
  static Future<bool> createOrUpdateUser(
    User firebaseUser, {
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      final userExists = await FirestoreService.userExists(firebaseUser.uid);

      if (userExists) {
        // Update existing user
        final updateData = <String, dynamic>{
          'email': firebaseUser.email,
          'displayName': firebaseUser.displayName,
          'photoURL': firebaseUser.photoURL,
          'phoneNumber': firebaseUser.phoneNumber,
          'isEmailVerified': firebaseUser.emailVerified,
          'updatedAt': Timestamp.now(),
        };

        if (additionalData != null) {
          updateData['additionalData'] = additionalData;
        }

        return await updateUserData(firebaseUser.uid, updateData);
      } else {
        // Create new user
        final userModel = UserModel.fromFirebaseUser(
          firebaseUser,
          additionalData: additionalData,
        );
        return await saveUserData(userModel);
      }
    } catch (e) {
      log('Error creating/updating user: $e');
      return false;
    }
  }

  // Get all users (untuk admin)
  static Future<List<UserModel>> getAllUsers() async {
    try {
      final querySnapshot = await _usersCollection.get();
      return querySnapshot.docs
          .map((doc) => UserModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      log('Error getting all users: $e');
      return [];
    }
  }

  // Search users by email
  static Future<List<UserModel>> searchUsersByEmail(String email) async {
    try {
      final querySnapshot = await _usersCollection
          .where('email', isGreaterThanOrEqualTo: email)
          .where('email', isLessThan: '${email}z')
          .get();

      return querySnapshot.docs
          .map((doc) => UserModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      log('Error searching users: $e');
      return [];
    }
  }
}
