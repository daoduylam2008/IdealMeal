import 'package:http/http.dart' as http;
// import 'DataTester.dart';

import 'dart:async';
import 'dart:convert';

String path = 'http://127.0.0.1:8000/api/v1/customers/151';

Future<String> fetchData() async {
  // List<UserTest> userList = [];

  final response = await http.get(Uri.parse(path));
  var data = jsonDecode(response.body)["data"];

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return data['name'];
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load json file');
  }
}
