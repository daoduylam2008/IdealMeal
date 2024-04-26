// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

import 'package:path_provider/path_provider.dart';

Future<String> get localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<dynamic> loadUserData() async {
  final String jsonString =
      await rootBundle.loadString('assets/user/user.json');
  final data = jsonDecode(jsonString);

  return data;
}

Future<File> get userData async {
  final path = await localPath;
  return File('$path/assets/user/user.json');
}

// Future<File> updatePassword(String password) async {
//   final file = await loadUserData;

//   // Write the file
//   return file('$counter');
// }