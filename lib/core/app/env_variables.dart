import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvVariables {
  EnvVariables._();

  static final EnvVariables instance = EnvVariables._();

  factory EnvVariables() => instance;

  static String _envToken = '';
  static String _envSentryDsn = '';

  static Future<void> init() async {
    await dotenv.load(fileName: '.env');

    _envToken = dotenv.get('TOKEN');
    _envSentryDsn = dotenv.get('SENTRY_DSN');
  }

  String get envToken => _envToken;
  String get envSentryDsn => _envSentryDsn;
}
