import 'package:http/http.dart' as http;
import 'constant.dart';

String path = 'http://127.0.0.1:8000/api/v1/customers/151';

Future<http.Response> fetchAlbum() {
  return http.get(Uri.parse(path));
}
