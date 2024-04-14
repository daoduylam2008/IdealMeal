import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var biometricsLogin = false;

// constants color
const Color accentColor = Color.fromRGBO(107, 31, 23, 1);
const Color accentColorLow = Color.fromRGBO(107, 31, 23, .9);
const Color myGrey = Color.fromRGBO(180, 180, 180, 1);
const Color appBarBackground = Color.fromRGBO(238, 238, 238, 1);

// Own gradient color
const linearColor = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color.fromRGBO(45, 154, 255, .9),
      Color.fromRGBO(255, 51, 112, .9),
    ]);

// constants path/url to data
const String pathToData = 'http://127.0.0.1:8000/api/v1/students';
const String urlToStudentData = 'http://127.0.0.1:8000/api/v1/students/1';
const String urlToMealsData = 'http://127.0.0.1:8000/api/v1/mealday';

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
  }
  else {
    day = "${date.day}";
  }

  return "$day/$month/${date.year}";
}

// icon path with {name}
String iconPath(String name) {
  return "assets/icons/$name icon.png";
}

TextStyle font(double size, Color color, FontWeight weight) {
  return GoogleFonts.inter(textStyle: TextStyle(
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

  Student({
    required this.id,
    required this.name,
    required this.birth,
    required this.gender,
    required this.phone,
    required this.cls,
    required this.address,
    required this.room});

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
      } =>
        Student(
            id: id,
            name: name,
            birth: birth,
            gender: gender,
            phone: phone,
            cls: cls,
            address: address,
            room: room),
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
  final String id;
  final String date;

  Meal({required this.id, required this.date});

  factory Meal.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'date': String date,
      } =>
        Meal(id: id, date: date),
      _ => throw const FormatException('Failed to load meal.')
    };
  }
}

// Test
var studentTest = Student(
    id: "100112",
    name: "Đào Duy Lâm",
    birth: "2008/08/31",
    gender: "boy",
    phone: "0909687714",
    cls: "10A01",
    address: "address",
    room: "D4116");

var userTest = User(
    id: "100112",
    username: "Đào Duy Lâm",
    password: "Lamdao",
    phone: "090968714");
