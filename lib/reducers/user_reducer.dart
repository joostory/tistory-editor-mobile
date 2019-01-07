import 'package:redux/redux.dart';
import 'package:tistory_editor/models/user.dart';
import 'package:tistory_editor/actions/actions.dart';

final userReducer = combineReducers<User>([
  TypedReducer<User, InitAction>(_setUser),
  TypedReducer<User, RemoveAuthAction>(_removeUser)
]);

User _setUser(user, action) {
  return action.user;
}

User _removeUser(user, action) {
  return null;
}
