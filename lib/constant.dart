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
const URL = "localhost:1111";
const MEAL = "/calendar";
const ORDER = "/order";

// convert Datetime to "DD/MM/YYYY"
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

// convert "YYYY/MM/DD" to Datetime
DateTime YYYYMMDDtoDate(String date) {
  List d = date.split("/");

  return DateTime(int.parse(d[0]), int.parse(d[1]), int.parse(d[2]));
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
  final String birth;
  final String gender;
  final String phone;
  final String cls;
  final String address;
  final String room;
  final String email;

  Student(
      {required this.id,
      required this.name,
      required this.birth,
      required this.gender,
      required this.phone,
      required this.cls,
      required this.address,
      required this.room,
      required this.email});

  factory Student.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'name': String name,
        'birth': String birth,
        'gender': String gender,
        'phone': String phone,
        'class': String cls,
        'address': String address,
        'room': String room,
        'email': String email
      } =>
        Student(
            id: id,
            name: name,
            birth: birth,
            gender: gender,
            phone: phone,
            cls: cls,
            address: address,
            room: room,
            email: email),
      _ => throw const FormatException('Failed to load student.')
    };
  }
}

class User {
  final String id;
  final String username;
  final String phone;
  String password;

  User({
    required this.id,
    required this.username,
    required this.phone,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        "username": String username,
        "phone": String phone,
        "password": String password,
      } =>
        User(id: id, username: username, phone: phone, password: password),
      _ => throw const FormatException('Failed to load user.')
    };
  }
}

class Meal {
  final String student_id;
  final String monday;
  final String tuesday;
  final String wednesday;
  final String thursday;
  final String friday;

  Meal(
      {required this.student_id,
      required this.monday,
      required this.tuesday,
      required this.wednesday,
      required this.thursday,
      required this.friday});

  Map<String, String> toMap() {
    return {
      'student_id': student_id,
      'Monday': monday,
      'Tuesday': tuesday,
      "Wednesday": wednesday,
      "Thursday": thursday,
      'Friday': friday,
    };
  }

  factory Meal.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'student_id': String id,
        'Monday': String monday,
        'Tuesday': String tuesday,
        "Wednesday": String wednesday,
        "Thursday": String thursday,
        'Friday': String friday,
      } =>
        Meal(
            student_id: id,
            monday: monday,
            tuesday: tuesday,
            wednesday: wednesday,
            thursday: thursday,
            friday: friday),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

// Test
var studentTest = Student(
  id: "100112",
  name: "Đào Duy Lâm",
  birth: "31/08/2008",
  gender: "boy",
  phone: "0909687714",
  cls: "10A01",
  address: "64 Nguyễn Bá Tòng, Phường Tân Thành, Quận Tân Phú",
  room: "D4116",
  email: "daoduylam2020@gmail.com",
);

var userTest = User(
    id: "100112",
    username: "Đào Duy Lâm",
    password: "Lamdao",
    phone: "090968714");

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
