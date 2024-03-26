import 'package:flutter/material.dart';

const double blackRectDY = 86;

const Color accentColor = Color.fromRGBO(107, 31, 23, 1);
const Color accentColorLow = Color.fromRGBO(107, 31, 23, .9);

const String pathToData = 'http://127.0.0.1:8000/api/v1/students';
String urlToStudentData = 'http://127.0.0.1:8000/api/v1/students/1';
String urlToMealsData = 'http://127.0.0.1:8000/api/v1/meals/1';

enum Users { student, teacher, admin }

class Student {
  final int id;
  final String name;
  final String birth;
  final String gender;
  final int phone;
  final String email;
  final String cls;
  final String address;
  final String ethnic;
  final String room;

  Student(
      {required this.id,
      required this.name,
      required this.birth,
      required this.gender,
      required this.phone,
      required this.email,
      required this.cls,
      required this.address,
      required this.ethnic,
      required this.room});

  factory Student.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'birth': String birth,
        'gender': String gender,
        'phone': int phone,
        'email': String email,
        'class': String cls,
        'address': String address,
        'ethnic': String ethnic,
        'room': String room,
      } => Student(id: id, name: name, birth: birth, gender: gender,phone: phone, email: email,  cls: cls, address: address, ethnic: ethnic, room : room),
      _ => throw const FormatException('Failed to load user.')
    };
  }
}

class Teacher {}

class User {
  final int id;
  final String username;
  final String password;
  final Users type;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.type,
  });

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "username": username,
      "password": password,
      "type": type,
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
