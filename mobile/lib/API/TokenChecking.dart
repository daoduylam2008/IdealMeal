import 'package:ideal_meal/API/RequestAPI.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isExpired(String token) {
  print("check token");
  return JwtDecoder.isExpired(token);
}

Future<String> getToken() async {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String> token = _prefs.then((pref) {
    return pref.getString("token") ?? "";
  });
  if (isExpired(await token)) {
    refreshToken();
    token = _prefs.then((pref) {
      return pref.getString("token") ?? "";
    });
  }

  return token;
}
