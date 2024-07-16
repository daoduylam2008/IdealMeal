import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

Future<Map<String, dynamic>> fetchCalendar(String student_id) async {
  var body = {"id": student_id};

  final newUri = Uri.http("localhost:1111", "/calendar", body);

  var response = await http.get(newUri);
  var meal = jsonDecode(response.body);
  print(response.statusCode.toString());
  print(meal.runtimeType);

  if (response.statusCode == 200) {
    return meal;
  } else {
    throw Exception("Failed to load json file");
  }
}
