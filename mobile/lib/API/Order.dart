import 'package:ideal_meal/API/ResponseApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getOrder() async {
  await fetchOrder();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var order = _prefs.then((pref) {
    return pref.getString("order") ?? "";
  });
  return order;
}
