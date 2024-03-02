import 'package:http/http.dart' as http;
import 'constant.dart';

Future<http.Response> fetchAlbum() {
  return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
}
