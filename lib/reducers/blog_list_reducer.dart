import 'package:redux/redux.dart';
import 'package:tistory_editor/actions/actions.dart';
import 'package:tistory_editor/models/blog.dart';

final blogListReducer = combineReducers<List<Blog>>([
  TypedReducer<List<Blog>, InitAction>(_setBlogList),
  TypedReducer<List<Blog>, RemoveAuthAction>(_removeBlogList)
]);

List<Blog> _setBlogList(blogList, action) {
  return action.blogList;
}

List<Blog> _removeBlogList(blogList, action) {
  return [];
}
