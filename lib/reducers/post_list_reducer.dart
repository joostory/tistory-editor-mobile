import 'package:redux/redux.dart';
import 'package:tistory_editor/actions/actions.dart';
import 'package:tistory_editor/models/post.dart';

final postListReducer = combineReducers<PostList>([
  TypedReducer<PostList, SelectBlogAction>(_selectBlog),
  TypedReducer<PostList, ReceivePostListAndCategoriesAction>(_receiveInitialPostList),
  TypedReducer<PostList, ReceivePostListAction>(_receivePostList),
  TypedReducer<PostList, SavePostContentAction>(_updatePost),
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

PostList _updatePost(PostList postList, action) {
  var index = postList.list.indexWhere((item) => item.id == action.post.id);
  if (index >= 0) {
    postList.list[index] = Post(
        action.post.id,
        action.post.title,
        action.post.url,
        action.visibility,
        action.post.categoryId,
        action.post.date
    );
  }
  return postList;
}