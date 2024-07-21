import 'package:jwt_decoder/jwt_decoder.dart';

bool isExpired(String token) {
  print("check token");
  return JwtDecoder.isExpired(token);
}
