import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tistory_editor/actions/actions.dart';
import 'package:tistory_editor/models/blog.dart';
import 'package:tistory_editor/reducers/app_reducer.dart';

class SliverBlogList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BlogListWidget();
  }
}

class BlogListWidget extends State<SliverBlogList> {
  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, List<Blog>>(
      converter: (store) => store.state.blogList,
      builder: (context, blogList) {
        return SliverList(
          delegate: SliverChildListDelegate(blogList.map((blog) {
            return GestureDetector(
              onTap: () {
                StoreProvider.of<AppState>(context).dispatch(SelectBlogAction(blog));
                Navigator.pushNamed(context, '/post/list');
              },
              child: _blogItem(blog)
            );
          }).toList())
        );
      }
    );
  }

  Widget _blogItem(Blog blog) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: blog.profileImage != null && blog.profileImage.isNotEmpty ? NetworkImage(blog.profileImage) : null,
            child: blog.profileImage == null || blog.profileImage.isEmpty ? Text(blog.title[0], style: TextStyle(color: Colors.white, fontSize: 20.0),) : null,
            radius: 20.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _blogInfoWidgets(blog)
            )
          ),
        ],
      ),
    );
  }

  _blogInfoWidgets(Blog blog) {
    List<Widget> blogInfoWidgets = [];
    blogInfoWidgets.add(
      Container(
        padding: EdgeInsets.only(bottom: 5.0),
        child: Text(
          blog.title,
          style: TextStyle(
              fontSize: 16.0
          )
        )
      )

    );

    if (blog.description.isNotEmpty) {
      blogInfoWidgets.add(
        Container(
          padding: EdgeInsets.only(bottom: 5.0),
          child: Text(
            blog.description,
          )
        )
      );
    }

    blogInfoWidgets.add(
      Container(
        child:Text(
          blog.url,
          style: TextStyle(
            color: Color(0xffaaaaaa)
          ),
        )
      )
    );

    return blogInfoWidgets;
  }

}