import 'package:tistory_editor/models/blog.dart';
import 'package:tistory_editor/models/post.dart';
import 'package:tistory_editor/models/user.dart';
import 'package:tistory_editor/reducers/user_reducer.dart';
import 'package:tistory_editor/reducers/auth_reducer.dart';
import 'package:tistory_editor/reducers/blog_list_reducer.dart';
import 'package:tistory_editor/reducers/selected_blog_reducer.dart';
import 'package:tistory_editor/reducers/post_list_reducer.dart';
import 'package:tistory_editor/reducers/selected_post_reducer.dart';

class AppState {
  String auth;
  User user;
  List<Blog> blogList;
  SelectedBlog selectedBlog;
  PostList postList;
  SelectedPost selectedPost;

  AppState(
    this.auth,
    this.user,
    this.blogList,
    this.selectedBlog,
    this.postList,
    this.selectedPost
  );

  static newEmptyInstance() {
    return AppState('', null, null, null, null, null);
  }
}


AppState appStateReducer(AppState state, action) => AppState(
  authReducer(state.auth, action),
  userReducer(state.user, action),
  blogListReducer(state.blogList, action),
  selectedBlogReducer(state.selectedBlog, action),
  postListReducer(state.postList, action),
  selectedPostReducer(state.selectedPost, action)
);
