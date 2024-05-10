import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:ideal_meal/constant.dart';

import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';

class MealStorage {
  bool _fileExists = true;
  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> getLocalFile() async {
    String path = await localPath;

    return File('$path/meal_data.json');
  }

  Future<File> writeMealData(Map<String, String> data) async {
    File file = await getLocalFile();

    String jsonString = jsonEncode(data);

    return file.writeAsString(jsonString);
  }

  Future<Map<String, dynamic>> readMealData() async {
    File file = await getLocalFile();
    _fileExists = file.existsSync();
    if (_fileExists) {
      final String response = file.readAsStringSync();
      final data = json.decode(response);
      for (var value in data.values) {
        if (data[value] == "") {
          data[value] = "Không chọn";
        }
      }
      return data;
    } else {
      return {};
    }
  }
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

class Date {
  DateTime firstDay = firstDate();
  DateTime lastDat = lastDate();

  late final List<List<DateTime>> dateMatrix;

  void init() {
    dateMatrix = matrix();
  }

  List<List<DateTime>> matrix() {
    List<String> days = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ];
    List<List<DateTime>> m = [];

    for (var i = 1; i <= 6; i++) {
      List<DateTime> d = [];
      for (var j = 1; j <= 7; j++) {
        d.add(DateTime(2024));
      }
      m.add(d);
    }

    for (var day in days) {
      if (day == dateToString(firstDay)) {
        int index = days.indexOf(day);
        m[0][index] = firstDay;
        for (var j = 1; j <= (days.length - index); j++) {
          m[0][index + j] = firstDay.copyWith(day: firstDay.day + j);
        }
        for (var j = 1; j <= 5; j++) {
          f
        }
        break;
      }
    }
    return m;
  }
}
