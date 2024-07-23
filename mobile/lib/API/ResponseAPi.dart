import 'package:http/http.dart' as http;
import 'package:ideal_meal/API/RequestAPI.dart';
import 'package:ideal_meal/API/TokenChecking.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'dart:convert';

import 'package:ideal_meal/constant.dart';

Future<Map<String, dynamic>> fetchCalendar() async {
  var user = await fetchProfile();
  var body = {"id": (await user.id).toString()};

  final uri = Uri.parse(URL_BACKEND + MEAL);
  final newUri = uri.replace(queryParameters: body);

  final response = await http.get(newUri);
  final meal = jsonDecode(response.body);

  if (response.statusCode == 200) {
    return meal;
  } else {
    throw Exception("Failed to load json file");
  }
}

Future<List<Map<String, dynamic>>> fetchOrder() async {
  var user = await fetchProfile();
  var body = {"id": (await user.id).toString()};
  final uri = Uri.parse(URL_BACKEND + ORDER).replace(queryParameters: body);

  final response = await http.get(uri);
  var order = jsonDecode(response.body).toList();

  if (response.statusCode == 200) {
    return order;
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

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  var token = _prefs.then((pref) {
    return pref.getString('token') ?? "none";
  });

  if (isExpired(await token)) {
    token = refreshToken();
  }

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

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  var token = _prefs.then((pref) {
    return pref.getString('token') ?? "none";
  });

  if (isExpired(await token)) {
    token = refreshToken();
  }

  final response = await http.get(uri,
      headers: {"Authorization": "Bearer " + (await token).toString()});

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
