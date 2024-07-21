import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

var biometricsLogin = false;

// constants color
const Color accentColor = Color.fromRGBO(107, 31, 23, 1);
const Color accentColorLow = Color.fromRGBO(107, 31, 23, .9);
const Color myGrey = Color.fromRGBO(180, 180, 180, 1);
const Color appBarBackground = Color.fromRGBO(242, 242, 242, 1);

// Own gradient color
const linearColor = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color.fromRGBO(45, 154, 255, .9),
      Color.fromRGBO(255, 51, 112, .9),
    ]);

const overlayLinearColor = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color.fromRGBO(45, 154, 255, .7),
      Color.fromRGBO(255, 51, 112, .7),
    ]);

// constants path/url to server
const URL_BACKEND = "http://localhost:1111";
const URL_SERVER = "http://localhost:8000";
const MEAL = "/calendar";
const ORDER = "/order";
const LOGIN = "/api/auth/login";
const PROFILE = "/api/auth/profile";
const REFRESH = "/api/auth/refresh";

// convert DateTime to "DD/MM/YYYY"
String dateToString(DateTime date) {
  String month = "${date.month}";
  String day = "${date.day}";

  if (month.length == 1) {
    month = "0${date.month}";
  } else {
    month = "${date.month}";
  }

  if (day.length == 1) {
    day = "0${date.day}";
  } else {
    day = "${date.day}";
  }

  return "$day/$month/${date.year}";
}

// convert "YYYY/MM/DD" to DateTime
DateTime YYYYMMDDtoDate(String date) {
  List d = date.split("/");

  return DateTime(int.parse(d[0]), int.parse(d[1]), int.parse(d[2]));
}

// convert DateTime to "" "YYYY/MM/DD"
String dateToYYYYMMDD(DateTime date) {
  return "${date.year}/${date.month}/${date.day}";
}

// Date transform
Map<String, String> dateDate = {
  "Monday": "MON",
  "Tuesday": "TUE",
  "Wednesday": "WED",
  "Thursday": " THU",
  "Friday": "FRI",
  "Saturday": "SAT",
  "Sunday": "SUN"
};

// icon path with {name}
String iconPath(String name) {
  return "assets/icons/$name icon.png";
}

TextStyle font(double size, Color color, FontWeight weight) {
  return GoogleFonts.inter(
      textStyle: TextStyle(
    fontSize: size,
    color: color,
    fontWeight: weight,
  ));
}

class Student {
  final String id;
  final String name;
  final String email;
  final String? created_at;
  final String? updated_at;

  Student({required this.id, required this.name, required this.email, required this.created_at, required this.updated_at});

  factory Student.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': String id, 'name': String name, 'email': String email} =>
        Student(id: id, name: name, email: email, created_at: null, updated_at: null),
      _ => throw const FormatException('Failed to load student.')
    };
  }
}

class User {
  final int id;
  final String name;
  final String phone;
  final String birth;
  final String room_id;

  User(
      {required this.id,
      required this.name,
      required this.phone,
      required this.room_id,
      required this.birth});

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'student_id': int id,
        "name": String name,
        "phone": String phone,
        "room_id": String room_id,
        "birth": String birth
      } =>
        User(id: id, name: name, phone: phone, room_id: room_id, birth: birth),
      _ => throw const FormatException('Failed to load user.')
    };
  }
}

DateTime firstDate() {
  var todayDate = DateTime.now();
  var firstDay = DateTime.utc(todayDate.year, todayDate.month, 1);

  return firstDay;
}

DateTime lastDate() {
  var todayDate = DateTime.now();
  var lastDay = DateTime.utc(todayDate.year, todayDate.month + 1, 0);

  return lastDay;
}

String dateToDay(DateTime date) {
  return DateFormat('EEEE').format(date);
}
