// ignore_for_file: unnecessary_nullable_for_final_variable_declarations

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static final String? baseUrl = dotenv.get('BASE_URL', fallback: 'BASE_URL not found');
}