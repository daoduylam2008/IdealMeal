// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:ideal_meal/constant.dart';

// Future<Meal> createMeal(Meal meals) async {
//   final response = await http.post(
//     Uri.parse(urlToMealsData),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//       'token': ''
//     },
//     body: jsonEncode(meals.toMap()),
//   );

//   if (response.statusCode == 201) {
//     // If the server did return a 201 CREATED response,
//     // then parse the JSON.
//     return Meal.fromJson(jsonDecode(response.body) as Map<String, String>);
//   } else {
//     print(response.statusCode);
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception('Failed to create album.');
//   }
// }

// // Future<Meal> upadateMeal(String id, String name, String date) async {
// //   final response = awai
// // }