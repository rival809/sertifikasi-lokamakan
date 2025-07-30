import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Debug utility untuk testing admin features
class AdminTestHelper {
  static bool _isTestMode = false;
  static String? _testUserId;

  // ValueNotifier untuk notifikasi perubahan state admin
  static final ValueNotifier<bool> adminStateNotifier =
      ValueNotifier<bool>(false);

  // Initialize notifier value
  static void _updateNotifier() {
    adminStateNotifier.value = isCurrentUserAdmin;
  }

  /// Enable test mode dengan user ID tertentu
  static void enableTestMode(String userId) {
    _isTestMode = true;
    _testUserId = userId;
    _updateNotifier(); // Notify listeners
    debugPrint('Admin Test Mode Enabled: User ID = $userId');
  }

  /// Disable test mode
  static void disableTestMode() {
    _isTestMode = false;
    _testUserId = null;
    _updateNotifier(); // Notify listeners
    debugPrint('Admin Test Mode Disabled');
  }

  /// Check apakah dalam test mode
  static bool get isTestMode => _isTestMode;

  /// Get test user ID
  static String? get testUserId => _testUserId;

  /// Check apakah current user adalah admin (dengan test mode support)
  static bool get isCurrentUserAdmin {
    // Jika dalam test mode, gunakan test user ID
    if (_isTestMode && _testUserId != null) {
      return _testUserId == "1";
    }

    // Normal mode: check actual user UID
    return SessionService.currentUserData?.uid == "1";
  }

  /// Show admin test dialog untuk enable/disable test mode
  static void showAdminTestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Admin Test Mode'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Current State: ${_isTestMode ? "Enabled" : "Disabled"}'),
              if (_isTestMode) Text('Test User ID: $_testUserId'),
              const SizedBox(height: 16),
              const Text(
                  'Enable test mode to access admin features without needing actual admin account.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            if (_isTestMode)
              TextButton(
                onPressed: () {
                  disableTestMode();
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Test mode disabled')),
                  );
                },
                child: const Text('Disable'),
              ),
            if (!_isTestMode)
              TextButton(
                onPressed: () {
                  enableTestMode("1");
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Test mode enabled as admin')),
                  );
                },
                child: const Text('Enable as Admin'),
              ),
          ],
        );
      },
    );
  }
}
