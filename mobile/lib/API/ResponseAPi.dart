import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import 'package:ideal_meal/API/TokenChecking.dart';
import 'package:ideal_meal/constant.dart';

Future<Map<String, dynamic>> fetchCalendar() async {
  var user = await fetchProfile();
  var body = {"id": (await user.id).toString()};

  final uri = Uri.parse(URL_BACKEND + MEAL);
  final newUri = uri.replace(queryParameters: body);
  String token = await getToken();

  final response = await http.get(newUri,
      headers: {"Authorization": "Bearer " + (await token).toString()});
  final meal = jsonDecode(response.body);

  if (response.statusCode == 200) {
    return meal;
  } else {
    throw Exception("Failed to load json file");
  }
}

Future<User> fetchProfile() async {
  final uri = Uri.parse(
    URL_SERVER + PROFILE,
  );

  """
  Use to get token which saved from preference data of user
  and basically it is noting in preference will return "none"
  software, in subsequent, may log out and refresh the token
  """;
  String token = await getToken();

  final response = await http.get(uri,
      headers: {"Authorization": "Bearer " + (await token).toString()});

  if (response.statusCode == 200) {
    if (token != "none") {
      return User.fromJson(jsonDecode(response.body));
    } else {
      return User(
          id: 0,
          name: "username",
          phone: "phone",
          room_id: "room_id",
          birth: "birth");
    }
  } else {
    throw Exception("Failed to load json file");
  }
}

Future<Student> fetchMe() async {
  final uri = Uri.parse(
    URL_SERVER + ME,
  );

  """
  Use to get token which saved from preference data of user
  and basically it is noting in preference will return "none"
  software, in subsequent, may log out and refresh the token
  """;
  String token = await getToken();

  final response = await http
      .get(uri, headers: {"Authorization": "Bearer " + (token).toString()});

  if (response.statusCode == 200) {
    if (token != "none") {
      return Student.fromJson(jsonDecode(response.body));
    } else {
      return Student(
          name: "name",
          email: "email",
          student_id: 100101,
          created_at: null,
          updated_at: null);
    }
  } else {
    throw Exception("Failed to load json file");
  }
}
