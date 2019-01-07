
class Blog {
  String id;
  String name;
  String title;
  String description;
  String profileImage;
  String url;

  Blog(
    this.id,
    this.name,
    this.title,
    this.description,
    this.profileImage,
    this.url,
  );
}

class Category {
  String id;
  String name;
  String label;

  Category(this.id, this.name, this.label);
}

class SelectedBlog {
  Blog blog;
  List<Category> categories;

  SelectedBlog(this.blog, this.categories);
}