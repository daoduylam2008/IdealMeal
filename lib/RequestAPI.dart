import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:student_attendance/constant.dart';

Future<http.Response> createRating() {
  return http.post(
    Uri.parse(urlToStudentData),
  );
}
