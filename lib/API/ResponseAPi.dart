import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

Future<void> fetchCalendar(String student_id) async {
  var params = {"id": student_id};

  Uri uri = Uri.parse("http://localhost:1111/calendar/");
  final newUri = uri.replace(queryParameters: params);

  var response = await http.get(newUri);
  var meal = jsonDecode(response.body);
  print(meal);

  if (response.statusCode == 200) {
    return meal;
  } else {
    throw Exception("Failed to load json file");
  }
}
