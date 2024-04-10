import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:student_attendance/constant.dart';

Future<http.Response> createMeal() {
  return http.post(
    Uri.parse(urlToMealsData),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
}
