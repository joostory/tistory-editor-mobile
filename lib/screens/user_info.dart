import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tistory_editor/actions/actions.dart';
import 'package:tistory_editor/models/user.dart';
import 'package:tistory_editor/reducers/app_reducer.dart';

class SliverUserInfoHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: UserInfoDelegate(),
    );
  }
}


class UserInfoDelegate implements SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return UserInfo();
  }

  @override
  double get maxExtent => 250.0;

  @override
  double get minExtent => 210.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;
}


class UserInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserInfoWidget();
  }
}

class UserInfoWidget extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {

    return new StoreConnector<AppState, User> (
      converter: (store) => store.state.user,
      builder: (context, user) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(user.profileImage),
                radius: 30.0,
              ),
              Text(
                user.name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16.0
                ),
              ),
              Text(
                  '(${user.email})',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 14.0
                  )
              ),
              RaisedButton(
                  child: Text('인증해제'),
                  onPressed: () {
                    StoreProvider.of<AppState>(context).dispatch(RemoveAuthAction());
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
        );
      },
    );


  }
}
