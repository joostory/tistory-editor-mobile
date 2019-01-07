import 'package:redux/redux.dart';
import 'package:tistory_editor/actions/actions.dart';
import 'package:tistory_editor/reducers/app_reducer.dart';
import 'package:tistory_editor/services/auth.dart';
import 'package:tistory_editor/services/tistory_api.dart';

Future loadPostList(Store<AppState> store, LoadPostListAction action, NextDispatcher next) async {
  var auth = await getAuth();
  if (auth != null) {
    final tistoryApi = TistoryApi(auth);
    final blogName = store.state.selectedBlog.blog.name;
    var postList = await tistoryApi.fetchPostList(blogName, 1);
    var categories = await tistoryApi.fetchCategories(blogName);

    store.dispatch(ReceivePostListAndCategoriesAction(postList, categories));
  }

  next(action);
}

Future loadPostContent(Store<AppState> store, LoadPostContentAction action, NextDispatcher next) async {
  var auth = await getAuth();
  if (auth != null) {
    final tistoryApi = TistoryApi(auth);
    final blogName = store.state.selectedBlog.blog.name;
    final post = store.state.selectedPost.post;
    var selectedPost = await tistoryApi.fetchPost(blogName, post);

    store.dispatch(ReceivePostContentAction(selectedPost));
  }
}