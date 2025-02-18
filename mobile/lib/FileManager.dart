import 'dart:convert';
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

  Future<File> writeMealData(Map<String, String?> data) async {
    clearFile(); // Cleared the meal_data.json file before add new data

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
          data[value] = "";
        }
      }
      return data;
    } else {
      return {};
    }
  }

  Future<File> clearFile() async {
    File file = await getLocalFile();

    String jsonString = jsonEncode("");

    return file.writeAsString(jsonString);
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
  Date() {
    init();
  }

  DateTime firstDay = firstDate();
  DateTime lastDay = lastDate();
  List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  List<List<DateTime>>? dateMatrix;

  void init() {
    dateMatrix = matrix();
  }

  List<List<DateTime>> matrix() {
    List<List<DateTime>> m = [];

    int first = days.indexOf(dateToDay(firstDay));

    for (var i = 1; i <= 6; i++) {
      List<DateTime> d = [];
      for (var j = 1; j <= 7; j++) {
        d.add(DateTime(2024));
      }
      m.add(d);
    }

    m[0][first] = firstDay;

    for (var i = 1; i <= 6 - first; i++) {
      m[0][first + i] = firstDay.copyWith(day: i + 1);
    }

    for (var i = 1; i <= 5; i++) {
      for (var j = 0; j <= 6; j++) {
        // m[i][j] = ;
      }
    }
    return m;
  }

  String dayDate(DateTime date) {
    if (date.month == firstDay.month) {
      double counter = 0;
      Map<String, DateTime> firstDays = {};
      firstDays[dateToDay(firstDay)] = firstDay;
      for (int i = 1; i <= 6; i++) {
        DateTime day = firstDay.copyWith(day: firstDay.day + i);
        firstDays[dateToDay(day)] = day;
      }
      for (var i in firstDays.values) {
        if ((i.day - date.day) % 7 == 0) {
          counter = (date.day - i.day) / 7 + 1;
        }
      }
      return "${dateToDay(date)}#${counter.toInt()}";
    }
    return "";
  }

  DateTime dateDay(String day) {
    if (day == "date") {
      return DateTime.now();
    }
    int y = days.indexOf(day.split("#")[0]);
    int x = int.parse(day.split("#")[1]) - 1;
    return dateMatrix![x][y];
  }
}
