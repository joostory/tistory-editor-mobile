import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tistory_editor/actions/actions.dart';
import 'package:tistory_editor/models/user.dart';
import 'package:tistory_editor/reducers/app_reducer.dart';
import 'package:tistory_editor/screens/blog_list.dart';
import 'package:tistory_editor/screens/user_info.dart';

class IndexScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, User>(
      converter: (store) => store.state.user,
      builder: (BuildContext context, User user) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: user == null ? ReadyWidget() : IndexWidget()
        );
      },
      onInit: (store) {
        store.dispatch(CheckAuthAction());
      },
    );
  }
}

class IndexWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverUserInfoHeader(),
          SliverBlogList()
        ],
      )
    );
  }

}

class ReadyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tistory',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xfff1631b),
              ),
            ),
            Text(
              ' Editor',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold
              )
            )
          ]
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text('인증하기'),
              onPressed: () {
                Navigator.pushNamed(context, '/auth/tistory');
              },
              color: Colors.black,
              textColor: Color(0xffffffff),
              highlightColor: Color(0xffff5544),
              disabledColor: Color(0xffb9b9b9),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)
              )
            )
          ],
        )
      ]
    );
  }
}