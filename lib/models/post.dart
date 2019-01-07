
class Post {
  String id;
  String title;
  String url;
  String visibility;
  String categoryId;
  String date;

  Post(
    this.id,
    this.title,
    this.url,
    this.visibility,
    this.categoryId,
    this.date
  );
}

class SelectedPost {
  Post post;
  String content;
  List tags;

  SelectedPost(this.post, this.content, this.tags);
}

class PostList {
  int page = 0;
  List<Post> list = [];
  bool hasNext = true;
}
