import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoURL;
  final String? phoneNumber;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isEmailVerified;
  final Map<String, dynamic>? additionalData;

  UserModel({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoURL,
    this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
    this.isEmailVerified = false,
    this.additionalData,
  });

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'phoneNumber': phoneNumber,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'isEmailVerified': isEmailVerified,
      'additionalData': additionalData,
    };
  }

  // Create from Firestore Document
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      displayName: map['displayName'],
      photoURL: map['photoURL'],
      phoneNumber: map['phoneNumber'],
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isEmailVerified: map['isEmailVerified'] ?? false,
      additionalData: map['additionalData'],
    );
  }

  // Create from Firebase User
  factory UserModel.fromFirebaseUser(
    dynamic firebaseUser, {
    Map<String, dynamic>? additionalData,
  }) {
    final now = DateTime.now();
    return UserModel(
      uid: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName,
      photoURL: firebaseUser.photoURL,
      phoneNumber: firebaseUser.phoneNumber,
      createdAt: now,
      updatedAt: now,
      isEmailVerified: firebaseUser.emailVerified ?? false,
      additionalData: additionalData,
    );
  }

  // Copy with method
  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoURL,
    String? phoneNumber,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isEmailVerified,
    Map<String, dynamic>? additionalData,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      additionalData: additionalData ?? this.additionalData,
    );
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, displayName: $displayName, photoURL: $photoURL, phoneNumber: $phoneNumber, createdAt: $createdAt, updatedAt: $updatedAt, isEmailVerified: $isEmailVerified)';
  }
}
