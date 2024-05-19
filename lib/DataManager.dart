import 'package:flutter/material.dart';

class MealDataProvider extends ChangeNotifier {
  Map<String, String?> _mealData = {};
  Map<String, String?> get mealData => _mealData;

  void updateMeal(Map<String, String?> map) {
    _mealData = map;
    notifyListeners(); // Notify listeners that the data has changed
  }
}
