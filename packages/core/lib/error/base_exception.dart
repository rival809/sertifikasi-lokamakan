abstract interface class BaseException {
  factory BaseException([var message]) => _BaseException(message);
}

/// Default implementation of [Exception] which carries a message.
class _BaseException implements BaseException {
  final dynamic message;

  _BaseException([this.message]);

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "Exception";
    return "$message";
  }
}
