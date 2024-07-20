import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import 'package:ideal_meal/constant.dart';

Future<Map<String, dynamic>> fetchCalendar(String student_id) async {
  var body = {"id": student_id};

  final uri = Uri.parse(URL_BACKEND + MEAL);
  final newUri = uri.replace(queryParameters: body);

  var response = await http.get(newUri);
  var meal = jsonDecode(response.body);

  if (response.statusCode == 200) {
    return meal;
  } else {
    throw Exception("Failed to load json file");
  }
}

Future<List<Map<String, dynamic>>> fetchOrder() async {
  final response = await http.get(Uri.parse(URL_BACKEND+ORDER));
  var order = jsonDecode(response.body);

  if (response.statusCode == 200) {
    print(order);
    return order;
  } else {
    throw Exception("Failed to load json file");
  }
}
