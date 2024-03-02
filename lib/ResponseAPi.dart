import 'package:http/http.dart' as http;
import 'constant.dart';

String path = 'https://jsonplaceholder.typicode.com/albums/1';

Future<http.Response> fetchAlbum() {
  return http.get(Uri.parse(path));
}
