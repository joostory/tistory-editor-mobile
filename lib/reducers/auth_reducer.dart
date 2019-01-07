import 'package:redux/redux.dart';
import 'package:tistory_editor/actions/actions.dart';

final authReducer = combineReducers<String>([
  TypedReducer<String, InitAction>(_setAuth),
  TypedReducer<String, RemoveAuthAction>(_removeAuth)
]);

String _setAuth(String state, InitAction action) {
  return action.auth;
}

String _removeAuth(String state, RemoveAuthAction action) {
  return '';
}
