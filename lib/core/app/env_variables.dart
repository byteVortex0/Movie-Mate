import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvVariables {
  EnvVariables._();

  static final EnvVariables instance = EnvVariables._();

  factory EnvVariables() => instance;

  static String _envToken = '';

  static Future<void> init() async {
    await dotenv.load(fileName: '.env');

    _envToken = dotenv.get('TOKEN');
  }

  String get envToken => _envToken;
}
