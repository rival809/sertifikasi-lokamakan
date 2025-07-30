import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:core/services/firestore_service.dart';
import 'package:core/services/auth_service.dart';
import 'package:core/models/user_model.dart';

class SessionService {
  static User? _currentUser;
  static UserModel? _currentUserData;
  static String _token = "";

  // Initialize session dengan Firebase Auth state
  static Future<void> initialize() async {
    try {
      // Listen to auth state changes
      FirebaseAuth.instance.authStateChanges().listen((User? user) async {
        _currentUser = user;

        if (user != null) {
          // Load user data dari Firestore
          await _loadUserData(user.uid);
        } else {
          // Clear session jika user logout
          await _clearSession();
        }
      });

      // Set current user if already logged in
      _currentUser = FirebaseAuth.instance.currentUser;
      if (_currentUser != null) {
        await _loadUserData(_currentUser!.uid);
      }
    } catch (e) {
      log('Error initializing session: $e');
    }
  }

  // Load user data dari Firestore
  static Future<void> _loadUserData(String uid) async {
    try {
      _currentUserData = await FirestoreService.getUserData(uid);
      if (_currentUserData != null) {
        log('User data loaded: ${_currentUserData!.email}');
      }
    } catch (e) {
      log('Error loading user data: $e');
    }
  }

  // Clear session data
  static Future<void> _clearSession() async {
    _currentUser = null;
    _currentUserData = null;
    _token = "";
  }

  // Getters untuk akses data session
  static User? get currentUser => _currentUser;
  static UserModel? get currentUserData => _currentUserData;
  static String get userUid => _currentUser?.uid ?? '';
  static String get userEmail => _currentUser?.email ?? '';
  static String get userDisplayName =>
      _currentUser?.displayName ?? _currentUserData?.displayName ?? '';
  static String? get userPhotoURL =>
      _currentUser?.photoURL ?? _currentUserData?.photoURL;
  static bool get isEmailVerified => _currentUser?.emailVerified ?? false;
  static bool get isLoggedIn => _currentUser != null;

  // Token management (untuk API calls jika diperlukan)
  static String get token => _token;
  static void setToken(String newToken) {
    _token = newToken;
  }

  // Update user data dan sync ke Firestore
  static Future<bool> updateUserData(Map<String, dynamic> data) async {
    if (_currentUser == null) return false;

    try {
      final success =
          await FirestoreService.updateUserData(_currentUser!.uid, data);
      if (success) {
        // Reload user data setelah update
        await _loadUserData(_currentUser!.uid);
      }
      return success;
    } catch (e) {
      log('Error updating user data: $e');
      return false;
    }
  }

  // Reload user data dari Firestore
  static Future<void> reloadUserData() async {
    if (_currentUser != null) {
      await _currentUser!.reload();
      _currentUser = FirebaseAuth.instance.currentUser;
      await _loadUserData(_currentUser!.uid);
    }
  }

  // Check apakah user sudah login dan verified
  static bool get isUserVerified => isLoggedIn && isEmailVerified;

  // Get user registration method dari additional data
  static String get registrationMethod {
    return _currentUserData?.additionalData?['registrationMethod'] ?? 'unknown';
  }

  // Get registration date
  static DateTime? get registrationDate {
    final dateString = _currentUserData?.additionalData?['registrationDate'];
    if (dateString != null) {
      return DateTime.tryParse(dateString);
    }
    return _currentUserData?.createdAt;
  }

  // Logout dan clear session
  static Future<void> logout() async {
    try {
      await AuthService.completeLogout();
      await _clearSession();
    } catch (e) {
      log('Error during logout: $e');
      // Fallback ke basic logout
      try {
        await AuthService.signOut();
        await _clearSession();
      } catch (fallbackError) {
        log('Fallback logout error: $fallbackError');
      }
    }
  }

  // Save additional user preferences
  static Future<bool> saveUserPreferences(
      Map<String, dynamic> preferences) async {
    if (_currentUser == null) return false;

    return await updateUserData({
      'additionalData.preferences': preferences,
    });
  }

  // Get user preferences
  static Map<String, dynamic> get userPreferences {
    return _currentUserData?.additionalData?['preferences'] ?? {};
  }

  // Stream untuk real-time user data updates
  static Stream<UserModel?> get userDataStream {
    if (_currentUser == null) {
      return Stream.value(null);
    }
    return FirestoreService.streamUserData(_currentUser!.uid);
  }
}
