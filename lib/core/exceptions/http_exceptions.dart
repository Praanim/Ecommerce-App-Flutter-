class AppException implements Exception {
  final String message;
  final int statusCode;
  final String identifier;

  AppException(
      {required this.message,
      required this.statusCode,
      required this.identifier});
  
}
