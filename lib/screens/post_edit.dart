import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:markdown/markdown.dart' as markdown;
import 'package:tistory_editor/models/post.dart';
import 'package:tistory_editor/reducers/app_reducer.dart';

class PostEditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SelectedPost>(
      converter: (store) => store.state.selectedPost,
      builder: (context, post) {
        return Scaffold(
          appBar: AppBar(
            title: Text(post.post.title),
          ),
          body: PostEditWidget(post.content),
        );
      }
    );
  }
}

class PostEditWidget extends StatefulWidget {
  final String _content;
  PostEditWidget(this._content);

  @override
  _PostEditWidgetState createState() => _PostEditWidgetState(_content);
}

class _PostEditWidgetState extends State<PostEditWidget> {
  String _content;
  String _markdown;
  TextEditingController _controller;

  _PostEditWidgetState(String content)
      : _content = content,
        _markdown = html2md.convert(content),
        _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = _markdown;
    _controller.addListener(handleChange);
  }

  handleChange() {
    _markdown = _controller.text;
    _content = markdown.markdownToHtml(_markdown);
    print('CHANGE: $_markdown');
    print('RESULT: $_content');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: TextField(
            maxLines: 100,
            controller: _controller
          ),
        )
      ],
    );
  }
}
