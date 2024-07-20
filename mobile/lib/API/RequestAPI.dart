import 'package:http/http.dart' as http;
import 'package:ideal_meal/constant.dart';

Future<bool> login(String email, String password) async {
  final response = await http.post(
    Uri.parse(URL_SERVER + LOGIN),
    body: {"email": email, "password": password},
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return true;
  } else if (response.statusCode == 401) {
    return false;
  } else {
    print(response.statusCode);
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to login');
  }
}
