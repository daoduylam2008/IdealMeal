import 'package:flutter/material.dart';
import 'package:ideal_meal/responsive_layout/mobile_layout/screens/LoginView.dart';
import 'package:ideal_meal/responsive_layout/mobile_layout/screens/UserView.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MobileScaffold extends StatefulWidget {
  const MobileScaffold({super.key});
  
  @override
  State<MobileScaffold> createState() => _MobileScaffold();
}

class _MobileScaffold extends State<MobileScaffold> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<bool> isLogin;

  @override
  void initState() {
    super.initState();
    // Create SharedPreference value, particularly islogin
    isLogin = _prefs.then((pref) {
      return pref.getBool('isLogin') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: isLogin,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                if (snapshot.data == true) {
                  return const UserView();
                }
                return const LoginView();
                
              }
          }
        });
  }
}
