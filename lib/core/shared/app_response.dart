class AppResponse {
  final int statusCode;
  final String? statusMessage;
  final dynamic data;

  AppResponse({
    required this.statusCode,
    this.statusMessage,
    this.data = const {},
  });

  @override
  String toString() {
    return 'statusCode=$statusCode\nstatusMessage=$statusMessage\n data=$data';
  }
}
