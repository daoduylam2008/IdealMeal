import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ideal_meal/API/ResponseAPI.dart';
import 'package:ideal_meal/API/TokenChecking.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ideal_meal/constant.dart';

Future<bool> login(String email, String password) async {
  Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
  Future<String> token = prefs0.then((pref) {
    return pref.getString("token") ?? "";
  });

  final response = await http.post(
    Uri.parse(URL_SERVER + LOGIN),
    body: {"email": email, "password": password},
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    final SharedPreferences prefs = await prefs0;
    token = prefs
        .setString('token', jsonDecode(response.body)["access_token"])
        .then((bool success) {
      return token;
    });

    return true;
  } else if (response.statusCode == 401) {
    return false;
  } else {
    print(response.statusCode);
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to login');
  }
}

Future<void> refreshToken() async {
  final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();

  var token = prefs0.then((pref) {
    return pref.getString('token') ?? "none";
  });

  final response = await http.post(
      headers: {"Authorization": "Bearer ${await token}"},
      Uri.parse(URL_SERVER + REFRESH));

  if (response.statusCode == 200) {
    final SharedPreferences prefs = await prefs0;

    var newToken = jsonDecode(response.body)["access_token"].toString();

    token = prefs
        .setString('token', newToken)
        .then((bool success) {
      return token;
    });
  }
}

Future<void> changeEmail(String email) async {
  String token = await getToken();

  final response = await http.post(
      headers: {"Authorization": "Bearer $token"},
      Uri.parse(URL_SERVER + REFRESH),
      body: {"email": email});

  if (response.statusCode == 200) {
  } else if (response.statusCode == 500) {
    throw Exception("Email or phone is already existed");
  } else {
    throw Exception("Error to change email");
  }
}

Future<void> changePhone(String phone) async {
  String token = await getToken();

  final response = await http.post(
      headers: {"Authorization": "Bearer " + (await token).toString()},
      Uri.parse(URL_SERVER + REFRESH),
      body: {"phone": phone});

  if (response.statusCode == 200) {
  } else if (response.statusCode == 500) {
    throw Exception("Email or phone is already existed");
  } else {
    throw Exception("Error to change email");
  }
}

Future<void> sendFeedback(
    String text, int rate, DateTime date, String dish_id) async {
  String token = await getToken();

  var user = await fetchProfile();

  var body = {
    "id": user.id,
    "name": user.name,
    "date": date,
    "dish_id": dish_id,
    "rate": rate,
    "text": text,
  };

  final response = await http.post(
      headers: {"Authorization": "Bearer " + (await token).toString()},
      Uri.parse(URL_SERVER + REFRESH),
      body: body);
  print(response);
}
