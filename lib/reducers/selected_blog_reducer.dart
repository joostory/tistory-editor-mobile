import 'package:redux/redux.dart';
import 'package:tistory_editor/actions/actions.dart';
import 'package:tistory_editor/models/blog.dart';

final selectedBlogReducer = combineReducers<SelectedBlog>([
  TypedReducer<SelectedBlog, SelectBlogAction>(_selectBlog),
  TypedReducer<SelectedBlog, ReceivePostListAndCategoriesAction>(_receiveCategories),
]);

SelectedBlog _selectBlog(state, action) {
  return SelectedBlog(action.blog, []);
}

SelectedBlog _receiveCategories(state, action) {
  return SelectedBlog(state.blog, action.categories);
}
