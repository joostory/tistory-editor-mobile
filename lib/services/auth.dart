import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

Future<String> getAuth() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth');
}

void removeAuth() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('auth');
}
