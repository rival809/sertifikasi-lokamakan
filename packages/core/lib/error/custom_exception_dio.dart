abstract interface class CustomExceptionDio {
  factory CustomExceptionDio([var message]) => _CustomExceptionDio(message);
}

/// Default implementation of [Exception] which carries a message.
class _CustomExceptionDio implements CustomExceptionDio {
  final dynamic message;

  _CustomExceptionDio([this.message]);

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "Exception";
    return "$message";
  }
}
