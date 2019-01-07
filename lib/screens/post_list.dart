import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tistory_editor/actions/actions.dart';
import 'package:tistory_editor/models/blog.dart';
import 'package:tistory_editor/models/post.dart';
import 'package:tistory_editor/reducers/app_reducer.dart';

class PostListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SelectedBlog>(
      converter: (store) => store.state.selectedBlog,
      builder: (context, blog) {
        return Scaffold(
          appBar: AppBar(
            title: blog != null ? Text(blog.blog.title) : Text('로딩 중'),
            backgroundColor: Colors.black,
          ),
          body: blog != null ? PostListWidget() : Loading(),
        );
      },
    );
  }
}

class PostListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PostList>(
      converter: (store) => store.state.postList,
      builder: (context, postList) {
        if (postList == null) {
          return Loading();
        }

        if (postList.list.length == 0) {
          return Text('글이 없습니다.');
        }

        return ListView.builder(
          itemBuilder: (context, index) {
            if (index >= postList.list.length) {
              return null;
            }

            return _postItem(context, postList.list[index]);
          },
        );
      },
      onInit: (store) {
        store.dispatch(LoadPostListAction());
      },
    );
  }

  Widget _postItem(BuildContext context, Post post) {
    return StoreConnector<AppState, List<Category>>(
      converter: (store) => store.state.selectedBlog.categories,
      builder: (context, categories) {
        var category;
        try {
          category = categories.singleWhere((item) => item.id == post.categoryId);
        } catch (e) {
          // ignore
        }

        return ListTile(
          title: Text(post.title),
          subtitle: category == null ? Text(post.date) : Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 5.0),
                child: Text(category.name, style: TextStyle(color: Color(0xfff1631b)))
              ),
              Text(post.date)
            ],
          ),
          onTap: () {
            var store = StoreProvider.of<AppState>(context);
            store.dispatch(SelectPostAction(post));
            Navigator.pushNamed(context, '/post/view');
          },
        );
      },
    );

  }
}


class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("로딩 중...")
            ],
          )
        ]
    );
  }
}