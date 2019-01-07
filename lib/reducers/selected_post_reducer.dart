import 'package:redux/redux.dart';
import 'package:tistory_editor/actions/actions.dart';
import 'package:tistory_editor/models/post.dart';

final selectedPostReducer = combineReducers<SelectedPost>([
  TypedReducer<SelectedPost, SelectPostAction>(_selectPost),
  TypedReducer<SelectedPost, ReceivePostContentAction>(_loadPostContent),
]);

SelectedPost _selectPost(post, action) {
  return SelectedPost(action.post, '', []);
}

SelectedPost _loadPostContent(post, action) {
  return action.post;
}