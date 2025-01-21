import 'package:flutter_dotenv/flutter_dotenv.dart';

class TokenService {
  TokenService();

  static Future<String?> getToken() async {
    await dotenv.load();
    return dotenv.get('MOVIE_DB_API_READ_ACCESS_TOKEN');
  }
}
