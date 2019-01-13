import 'package:redux/redux.dart';
import 'package:tistory_editor/actions/actions.dart';
import 'package:tistory_editor/reducers/app_reducer.dart';
import 'package:tistory_editor/middleware/auth_middleware.dart';
import 'package:tistory_editor/middleware/blog_middleware.dart';

List<Middleware<AppState>> createMiddleware() {
  return [
    TypedMiddleware<AppState, dynamic>(_log),
    TypedMiddleware<AppState, CheckAuthAction>(checkAuth),
    TypedMiddleware<AppState, RemoveAuthAction>(disconnect),
    TypedMiddleware<AppState, LoadPostListAction>(loadPostList),
    TypedMiddleware<AppState, LoadPostContentAction>(loadPostContent),
    TypedMiddleware<AppState, SavePostContentAction>(savePostContent),
  ];
}

void _log(Store<AppState> store, action, NextDispatcher next) {
  print('[Action] ${new DateTime.now()}: $action');

  next(action);
}
