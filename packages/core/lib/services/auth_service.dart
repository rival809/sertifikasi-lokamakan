import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:core/services/firestore_service.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Initialize auth service
  static Future<void> initialize() async {
    try {
      // For development: Disable reCAPTCHA enforcement
      await _auth.setSettings(
        appVerificationDisabledForTesting: true,
        forceRecaptchaFlow: false,
      );
    } catch (e) {
      log('AuthService initialization warning: $e');
    }
  }

  // Get current user
  static User? get currentUser => _auth.currentUser;

  // Stream of authentication state changes
  static Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with email and password
  static Future<AuthResult> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthResult.success(credential.user);
    } on FirebaseAuthException catch (e) {
      return AuthResult.failure(_getErrorMessage(e.code));
    } catch (e) {
      return AuthResult.failure('Terjadi kesalahan yang tidak terduga');
    }
  }

  // Sign up with email and password
  static Future<AuthResult> signUpWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      final UserCredential credential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        // Update display name jika disediakan
        if (displayName != null && displayName.isNotEmpty) {
          log('Setting displayName: $displayName for user: ${credential.user!.email}');

          await credential.user!.updateDisplayName(displayName);
          await credential.user!.reload();

          // Refresh current user reference setelah update
          final updatedUser = _auth.currentUser;
          log('Updated user displayName: ${updatedUser?.displayName}');

          if (updatedUser != null) {
            // Simpan data user ke Firestore dengan displayName yang sudah terupdate
            try {
              await FirestoreService.createOrUpdateUser(
                updatedUser,
                additionalData: additionalData,
              );
            } catch (firestoreError) {
              log('Warning: Failed to save user data to Firestore: $firestoreError');
              // Continue dengan auth success meskipun Firestore gagal
            }
          }
        } else {
          // Jika tidak ada displayName, simpan langsung
          try {
            await FirestoreService.createOrUpdateUser(
              credential.user!,
              additionalData: additionalData,
            );
          } catch (firestoreError) {
            log('Warning: Failed to save user data to Firestore: $firestoreError');
            // Continue dengan auth success meskipun Firestore gagal
          }
        }
      }

      return AuthResult.success(_auth.currentUser);
    } on FirebaseAuthException catch (e) {
      // Handle specific reCAPTCHA errors dengan fallback
      if (e.code == 'unknown' &&
          (e.message?.contains('CONFIGURATION_NOT_FOUND') == true ||
              e.message?.contains('RecaptchaAction') == true)) {
        // Untuk development, kita beri informasi yang jelas ke user
        return AuthResult.failure(
            'Konfigurasi keamanan belum lengkap. Gunakan Google Sign-In untuk sementara atau hubungi administrator.');
      }

      return AuthResult.failure(_getErrorMessage(e.code));
    } catch (e) {
      log('General error: $e');
      return AuthResult.failure('Terjadi kesalahan yang tidak terduga');
    }
  }

  // Sign in with Google
  static Future<AuthResult> signInWithGoogle({
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return AuthResult.failure('Login Google dibatalkan');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        // Simpan/update data user ke Firestore
        try {
          await FirestoreService.createOrUpdateUser(
            userCredential.user!,
            additionalData: additionalData,
          );
        } catch (firestoreError) {
          log('Warning: Failed to save Google user data to Firestore: $firestoreError');
          // Continue dengan auth success meskipun Firestore gagal
        }
      }

      return AuthResult.success(userCredential.user);
    } catch (e) {
      return AuthResult.failure('Gagal login dengan Google: ${e.toString()}');
    }
  }

  // Sign out
  static Future<void> signOut() async {
    await Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  // Send password reset email
  static Future<AuthResult> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return AuthResult.success(null);
    } on FirebaseAuthException catch (e) {
      return AuthResult.failure(_getErrorMessage(e.code));
    } catch (e) {
      return AuthResult.failure('Terjadi kesalahan yang tidak terduga');
    }
  }

  // Send email verification
  static Future<AuthResult> sendEmailVerification() async {
    try {
      if (_auth.currentUser != null) {
        await _auth.currentUser!.sendEmailVerification();
        return AuthResult.success(_auth.currentUser);
      } else {
        return AuthResult.failure('Tidak ada user yang sedang login');
      }
    } on FirebaseAuthException catch (e) {
      return AuthResult.failure(_getErrorMessage(e.code));
    } catch (e) {
      return AuthResult.failure('Terjadi kesalahan yang tidak terduga');
    }
  }

  // Reload user data
  static Future<void> reloadUser() async {
    if (_auth.currentUser != null) {
      await _auth.currentUser!.reload();
    }
  }

  // Check if email is verified
  static bool get isEmailVerified => _auth.currentUser?.emailVerified ?? false;

  // Update display name
  static Future<AuthResult> updateDisplayName(String displayName) async {
    try {
      if (_auth.currentUser != null) {
        await _auth.currentUser!.updateDisplayName(displayName);
        return AuthResult.success(_auth.currentUser);
      } else {
        return AuthResult.failure('Tidak ada user yang sedang login');
      }
    } catch (e) {
      return AuthResult.failure('Gagal update nama: ${e.toString()}');
    }
  }

  // Check if user is signed in
  static bool get isSignedIn => _auth.currentUser != null;

  // Get user email
  static String? get userEmail => _auth.currentUser?.email;

  // Get user display name
  static String? get userDisplayName => _auth.currentUser?.displayName;

  // Get user photo URL
  static String? get userPhotoURL => _auth.currentUser?.photoURL;

  // Convert Firebase error codes to user-friendly messages
  static String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'Email tidak ditemukan. Silakan daftar terlebih dahulu.';
      case 'wrong-password':
        return 'Kata sandi salah. Silakan coba lagi.';
      case 'invalid-email':
        return 'Format email tidak valid.';
      case 'user-disabled':
        return 'Akun ini telah dinonaktifkan.';
      case 'too-many-requests':
        return 'Terlalu banyak percobaan. Silakan coba lagi nanti.';
      case 'email-already-in-use':
        return 'Email sudah digunakan oleh akun lain.';
      case 'weak-password':
        return 'Kata sandi terlalu lemah. Minimal 6 karakter.';
      case 'invalid-credential':
        return 'Email atau kata sandi tidak valid.';
      case 'captcha-check-failed':
        return 'Verifikasi keamanan gagal. Silakan coba lagi.';
      case 'invalid-app-credential':
        return 'Konfigurasi aplikasi tidak valid. Silakan hubungi administrator.';
      case 'unknown':
        return 'Terjadi kesalahan sistem. Silakan coba dengan Google Sign-In.';
      default:
        return 'Terjadi kesalahan. Silakan coba lagi.';
    }
  }
}

// Auth result class to handle success and failure states
class AuthResult {
  final bool isSuccess;
  final User? user;
  final String? errorMessage;

  AuthResult._({
    required this.isSuccess,
    this.user,
    this.errorMessage,
  });

  factory AuthResult.success(User? user) {
    return AuthResult._(
      isSuccess: true,
      user: user,
    );
  }

  factory AuthResult.failure(String errorMessage) {
    return AuthResult._(
      isSuccess: false,
      errorMessage: errorMessage,
    );
  }
}
