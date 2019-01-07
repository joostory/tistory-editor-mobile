import 'package:flutter/services.dart' show rootBundle;

Future<String> readTextAsset(String path) async {
  return rootBundle.loadString(path);
}
