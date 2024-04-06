import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const double blackRectDY = 87;

const Offset homeOffset = Offset(79, blackRectDY);
const Offset mealOffset = Offset(166, blackRectDY);
const Offset orderOffset = Offset(250.5, blackRectDY);
const Offset profileOffset = Offset(335, blackRectDY);

const Color accentColor = Color.fromRGBO(107, 31, 23, 1);
const Color accentColorLow = Color.fromRGBO(107, 31, 23, .9);
const linearColor = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color.fromRGBO(45, 154, 255, .9),
      Color.fromRGBO(255, 51, 112, .9),
    ]);

const String pathToData = 'http://127.0.0.1:8000/api/v1/students';
String urlToStudentData = 'http://127.0.0.1:8000/api/v1/students/1';
String urlToMealsData = 'http://127.0.0.1:8000/api/v1/meals/1';


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
  final int id;
  final String name;
  final String birth;
  final String gender;
  final String phone;
  final String cls;
  final String address;
  final String room;

  Student(
      {required this.id,
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
        'id': int id,
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
      _ => throw const FormatException('Failed to load user.')
    };
  }
}

class User {
  final int id;
  final String username;
  final String password;

  User({
    required this.id,
    required this.username,
    required this.password,
  });

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "username": username,
      "password": password,
    };
  }
}

class Rating {
  final int id;
  final String name;
  final int rate;
  final String comment;

  Rating({
    required this.id,
    required this.name,
    required this.rate,
    required this.comment,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'rate': int rate,
        'comment': String comment
      } =>
        Rating(id: id, name: name, rate: rate, comment: comment),
      _ => throw const FormatException('Failed to load rating.')
    };
  }
}

var studentTest = Student(
    id: 100112,
    name: "Đào Duy Lâm",
    birth: "2008/08/31",
    gender: "boy",
    phone: "0909687714",
    cls: "10A01",
    address: "address",
    room: "D4116");

var userTest = User(
    id: 100112,
    username: "Đào Duy Lâm", 
    password: "Lamdao");
