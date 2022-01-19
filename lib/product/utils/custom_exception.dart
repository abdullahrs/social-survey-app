class FetchDataException implements Exception {
  final String message;
  // -1 resend
  final int statusCode;
  final Exception? exception;

  FetchDataException(
      {required this.message,
      required this.statusCode,
      this.exception});
}
