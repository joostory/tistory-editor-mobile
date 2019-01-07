import 'dart:convert';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tistory_editor/actions/actions.dart';
import 'package:tistory_editor/reducers/app_reducer.dart';
import 'package:tistory_editor/services/assets.dart';

class TistoryAuthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TistoryAuthWidget();
  }
}

class TistoryAuthWidget extends State<TistoryAuthScreen> {

  Map _authInfo;

  @override
  void initState() {
    super.initState();
    readTextAsset('assets/authInfo.json').then((data) {
      setState(() {
        _authInfo = jsonDecode(data);
      });
    });

    final flutterWebviewPlugin = new FlutterWebviewPlugin();
    flutterWebviewPlugin.onUrlChanged.listen((url) {
      Map<String, String> params = Uri.parse(url).queryParameters;
      if (params.containsKey('code')) {
        _fetchAccessToken(params['code'], context);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    if (_authInfo == null) {
      return Scaffold(
        appBar: new AppBar(
          title: new Text("티스토리 인증", style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.black,
        ),
        body: Text('준비 중')
      );
    }

    var url = '${_authInfo['authorizationUrl']}'
        '?client_id=${_authInfo['clientId']}'
        '&redirect_uri=${_authInfo['redirectUri']}'
        '&response_type=code';
    return WebviewScaffold(
      url: url,
      appBar: new AppBar(
        title: new Text("티스토리 인증", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      initialChild: Container(
        child: const Center(
          child: Text('Waiting.....'),
        ),
      )
    );
  }

  Future _fetchAccessToken(String code, BuildContext context) async {
    var url = '${_authInfo['tokenUrl']}'
        '?client_id=${_authInfo['clientId']}'
        '&client_secret=${_authInfo['clientSecret']}'
        '&redirect_uri=${_authInfo['redirectUri']}'
        '&code=${code}'
        '&grant_type=authorization_code';
    final response = await http.get(url, headers: {
      'Content-type': 'application/json'
    });
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('auth', response.body.substring(13));

      StoreProvider.of<AppState>(context).dispatch(CheckAuthAction());

      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    }
  }
}
