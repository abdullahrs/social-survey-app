class FetchDataException implements Exception {
  final String message;
  final int statusCode;
  final Exception? exception;

  FetchDataException(
      {required this.message,
      required this.statusCode,
      this.exception});
}
