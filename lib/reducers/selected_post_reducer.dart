import 'package:redux/redux.dart';
import 'package:tistory_editor/actions/actions.dart';
import 'package:tistory_editor/models/post.dart';

final selectedPostReducer = combineReducers<PostDetail>([
  TypedReducer<PostDetail, SelectPostAction>(_selectPost),
  TypedReducer<PostDetail, ReceivePostContentAction>(_loadPostContent),
]);

PostDetail _selectPost(post, action) {
  return PostDetail(action.post, '', []);
}

PostDetail _loadPostContent(post, action) {
  return action.post;
}