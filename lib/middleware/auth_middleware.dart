import 'package:redux/redux.dart';
import 'package:tistory_editor/actions/actions.dart';
import 'package:tistory_editor/models/blog.dart';
import 'package:tistory_editor/reducers/app_reducer.dart';
import 'package:tistory_editor/services/auth.dart';
import 'package:tistory_editor/services/tistory_api.dart';

Future checkAuth(Store<AppState> store, action, NextDispatcher next) async {
  var auth = await getAuth();
  if (auth != null) {
    final tistoryApi = TistoryApi(auth);
    var user = await tistoryApi.fetchUser();
    List<Blog> blogList = await tistoryApi.fetchBlogList();

    store.dispatch(InitAction(auth, user, blogList));
  }
  next(action);
}

Future disconnect(Store<AppState> store, action, NextDispatcher next) async {
  removeAuth();
  next(action);
}