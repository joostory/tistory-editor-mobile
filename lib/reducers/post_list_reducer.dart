import 'package:redux/redux.dart';
import 'package:tistory_editor/actions/actions.dart';
import 'package:tistory_editor/models/post.dart';

final postListReducer = combineReducers<PostList>([
  TypedReducer<PostList, SelectBlogAction>(_selectBlog),
  TypedReducer<PostList, ReceivePostListAndCategoriesAction>(_receiveInitialPostList),
  TypedReducer<PostList, ReceivePostListAction>(_receivePostList),
]);

PostList _selectBlog(postList, action) {
  return PostList();
}

PostList _receiveInitialPostList(postList, action) {
  return action.postList;
}

PostList _receivePostList(postList, action) {
  var nextPostList = PostList();
  nextPostList.page = action.page;
  nextPostList.list.addAll(action.list);
  nextPostList.hasNext = action.hasNext;
  return nextPostList;
}
