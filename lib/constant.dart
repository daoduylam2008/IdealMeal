import 'package:flutter/material.dart';

const Color accentColor = Color.fromRGBO(107, 31, 23, 1);
const Color accentColorLow = Color.fromRGBO(107, 31, 23, .9);

const String pathToData = 'http://127.0.0.1:8000/api/v1/customers/151';

enum Gender { male, female }

enum Users { student, teacher, admin }

class Student {
  final int id;
  final String name;
  final DateTime birth;
  final String place_of_birth;
  final Gender gender;
  final String phone_number;
  final String email;
  final String parents_phone_number;
  final String cls;
  final String address;
  final String ethnic;

  Student({
    required this.id,
    required this.name,
    required this.birth,
    required this.place_of_birth,
    required this.gender,
    required this.phone_number,
    required this.email,
    required this.parents_phone_number,
    required this.cls,
    required this.address,
    required this.ethnic,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      "name": name,
      "birth": birth,
      "place of birth": place_of_birth,
      "gender": gender,
      "phone number": phone_number,
      "email": email,
      "parents phone number": parents_phone_number,
      "class": cls,
    };
  }
}

class Teacher {}

class User {
  final int id;
  final String username;
  final Users type;

  User({
    required this.id,
    required this.username,
    required this.type,
  });

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "username": username,
      "type": type,
    };
  }
}
