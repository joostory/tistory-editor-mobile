
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

class PostDetail extends Post {
  String content;
  List tags;

  PostDetail(
    Post post,
    String content,
    List tags
  ):
    this.content = content,
    this.tags = tags,
    super(post.id, post.title, post.url, post.visibility, post.categoryId, post.date);
}

class PostList {
  int page = 0;
  List<Post> list = [];
  bool hasNext = true;
}
