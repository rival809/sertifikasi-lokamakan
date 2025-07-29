import 'dart:developer';

class FavoriteEventManager {
  static Function()? _onFavoriteChanged;

  static void setListener(Function() callback) {
    _onFavoriteChanged = callback;
  }

  static void clearListener() {
    _onFavoriteChanged = null;
  }

  static void notifyFavoriteChanged() {
    try {
      if (_onFavoriteChanged != null) {
        _onFavoriteChanged!();
      }
    } catch (e) {
      log('Error notifying favorite changed: $e');
    }
  }
}
