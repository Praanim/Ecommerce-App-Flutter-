import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static final baseUrl = dotenv.env['BASE_URL']!;

  static const Map<String, Object> defaultHeaders = {
    'accept': 'application/json',
    'content-type': 'application/json',
  };
}
