import 'package:http/http.dart' as http;
import 'DataTester.dart';

import 'dart:async';
import 'dart:convert';


String path = 'http://127.0.0.1:8000/api/v1/customers/151';

Future<ImportData> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ImportData.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load json file');
  }
}
