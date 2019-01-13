import 'package:tistory_editor/models/blog.dart';
import 'package:tistory_editor/models/post.dart';
import 'package:tistory_editor/models/user.dart';

class CheckAuthAction {}

class InitAction {
  String auth;
  User user;
  List<Blog> blogList;

  InitAction(this.auth, this.user, this.blogList);
}

class RemoveAuthAction {}

class SelectBlogAction {
  Blog blog;

  SelectBlogAction(this.blog);
}

class LoadPostListAction {}

class ReceivePostListAndCategoriesAction {
  PostList postList;
  List<Category> categories;

  ReceivePostListAndCategoriesAction(this.postList, this.categories);
}

class ReceiveCategoriesAction {
  List<Category> categories;

  ReceiveCategoriesAction(this.categories);
}

class ReceivePostListAction {
  int page;
  List<Post> list;
  bool hasNext;

  ReceivePostListAction(this.page, this.list, this.hasNext);
}

class SelectPostAction {
  Post post;

  SelectPostAction(this.post);
}

class LoadPostContentAction {}

class ReceivePostContentAction {
  PostDetail post;

  ReceivePostContentAction(this.post);
}

class SavePostContentAction {
  PostDetail post;
  String visibility;

  SavePostContentAction(this.post, this.visibility);
}
