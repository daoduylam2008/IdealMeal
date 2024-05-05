import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';

Future<String> get localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> getLocalFile() async {
  String path = await localPath;

  return File('$path/meal_data.json');
}

Future<File> writeMealData(Map<String, String>data) async {
  File file = await getLocalFile();

  return file.writeAsString("$data");
}

Future<Map<String, String>> readMealData() async {
  File file = await getLocalFile();

  final String response = await rootBundle.loadString(file.path);
  final data = await json.decode(response);

  return data;
}

Future<List<List<dynamic>>> processCsv(String path) async {
  var result = await rootBundle.loadString(
    path,
  );

  return const CsvToListConverter().convert(result, eol: "\n");
}

Map<String, String> mealCode(List<List<dynamic>> data) {
  Map<String, String> map = {};
  for (var element in data) {
    map[element[0].split(";")[1]] = element[0].split(";")[0];
  }

  return map;
}

Map<String, List<String>> dayMeal(List<List<dynamic>> data) {
  Map<String, List<String>> map = {};
  for (var element1 in data) {
    List<String> temp = [];

    for (var element2 in data) {
      if (element1[0].split(";")[2] == element2[0].split(";")[2]) {
        temp.add(element2[0].split(";")[1]);
      }
    }
    map[element1[0].split(";")[2]] = temp + ["Không chọn"];
  }
  return map;
}
