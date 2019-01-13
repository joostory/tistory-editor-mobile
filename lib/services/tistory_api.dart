import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tistory_editor/models/blog.dart';
import 'package:tistory_editor/models/post.dart';
import 'package:tistory_editor/models/user.dart';

const BaseUrl = 'https://www.tistory.com/apis';

class TistoryApi {
  String _auth;
  TistoryApi(this._auth);

  Future<User> fetchUser() async {
    var url = '$BaseUrl'
        '/user'
        '?access_token=$_auth'
        '&output=json';
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json'
    });
    if (response.statusCode != 200) {
      throw Exception();
    }

    var result = jsonDecode(response.body)['tistory']['item'];
    return User(result['name'], result['loginId'], result['image']);
  }

  Future<List<Blog>> fetchBlogList() async {
    var url = '$BaseUrl'
        '/blog/info'
        '?access_token=$_auth'
        '&output=json';
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json'
    });
    if (response.statusCode != 200) {
      throw Exception();
    }

    List results = jsonDecode(response.body)['tistory']['item']['blogs'];
    return results.map((item) => Blog(
      item['blogId'],
      item['name'],
      item['title'],
      item['description'],
      item['profileThumbnailImageUrl'],
      item['url']
    )).toList();
  }

  Future<List<Category>> fetchCategories(String blogName) async {
    var url = '$BaseUrl'
        '/category/list'
        '?access_token=$_auth'
        '&output=json'
        '&blogName=$blogName';
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json'
    });
    if (response.statusCode != 200) {
      throw Exception();
    }

    List results = jsonDecode(response.body)['tistory']['item']['categories'];
    return results.map((item) => Category(
      item['id'],
      item['name'],
      item['label']
    )).toList();
  }

  Future<PostList> fetchPostList(String blogName, int nextPage) async {
    var url = '$BaseUrl'
        '/post/list'
        '?access_token=$_auth'
        '&output=json'
        '&blogName=$blogName'
        '&count=30'
        '&page=$nextPage';
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json'
    });
    if (response.statusCode != 200) {
      throw Exception();
    }

    var result = jsonDecode(response.body)['tistory']['item'];

    var postList = PostList();
    postList.page = int.parse(result['page']);
    postList.hasNext = int.parse(result['totalCount']) > int.parse(result['page']) * int.parse(result['count']);
    List resultList = result['posts'];
    postList.list = resultList.map((item) => Post(
      item['id'],
      item['title'],
      item['postUrl'],
      item['visibility'],
      item['categoryId'],
      item['date']
    )).toList();

    return postList;
  }

  Future<PostDetail> fetchPost(String blogName, Post post) async {
    var url = '$BaseUrl'
        '/post/read'
        '?access_token=$_auth'
        '&output=json'
        '&blogName=$blogName'
        '&postId=${post.id}';
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json'
    });
    if (response.statusCode != 200) {
      throw Exception();
    }

    Map result = jsonDecode(response.body)['tistory']['item'];
    var tags = result.containsKey('tags') && result['tags'] is Map? result['tags']['tag'] : [];
    return PostDetail(
      post,
      result['content'],
      tags
    );
  }

  Future savePost(String blogName, PostDetail post, String visibility) async {
    //
    var url = '$BaseUrl'
        '/post/modify'
        '?access_token=$_auth'
        '&output=json'
        '&blogName=$blogName'
        '&postId=${post.id}';

    var body = {
      'access_token': _auth,
      'output': 'json',
      'blogName': blogName,
      'postId': post.id,
      'title': post.title,
      'content': post.content,
      'visibility': visibility,
      'category': post.categoryId,
      'tag': post.tags.join(',')
    };

    final response = await http.post(url,
      body: body
    );
    if (response.statusCode != 200) {
      throw Exception();
    }
  }
}
