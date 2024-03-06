import 'package:http/http.dart' as http;
// import 'DataTester.dart';

import 'dart:async';
import 'dart:convert';

import 'package:student_attendance/DataTester.dart';

String path = 'http://127.0.0.1:8000/api/v1/students';

Future<UserTest> fetchStudentData() async {
  // List<UserTest> userList = [];

  final response = await http.get(Uri.parse(path));
  var data = jsonDecode(response.body)["data"];

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return UserTest.fromJson(data as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load json file');
  }
}

Future<List<dynamic>> fetchStudentsData() async {
  final response = await http.get(Uri.parse(path));
  var data = jsonDecode(response.body);

  if (response.statusCode == 200) {
    return data;
  } else {
    throw Exception("Failed to load json file");
  }
}
