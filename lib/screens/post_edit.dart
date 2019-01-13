import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:markdown/markdown.dart' as markdown;
import 'package:redux/redux.dart';
import 'package:tistory_editor/actions/actions.dart';
import 'package:tistory_editor/models/blog.dart';
import 'package:tistory_editor/models/post.dart';
import 'package:tistory_editor/reducers/app_reducer.dart';

class PostEditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PostDetail>(
      converter: (store) => store.state.selectedPost,
      builder: (context, post) {
        return PostEditWidget(post);
      }
    );
  }
}

class PostEditWidget extends StatefulWidget {
  final PostDetail _post;
  PostEditWidget(this._post);

  @override
  _PostEditWidgetState createState() => _PostEditWidgetState(_post);
}

class _PostEditWidgetState extends State<PostEditWidget> {
  PostDetail _post;
  String _markdown;
  TextEditingController _contentController;
  TextEditingController _titleController;

  _PostEditWidgetState(PostDetail post)
      : _post = post,
        _markdown = html2md.convert(post.content),
        _contentController = TextEditingController(),
        _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _contentController.text = _markdown;
    _contentController.addListener(() {
      _markdown = _contentController.text;
      setState(() {
        _post.content = markdown.markdownToHtml(_markdown);
      });
    });

    _titleController.text = _post.title;
    _titleController.addListener(() {
      setState(() {
        _post.title = _titleController.text;
      });
    });
  }

  _showPublishDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('발행'),
          actions: <Widget>[
            FlatButton(
              child: Text('저장'),
              onPressed: () {
                StoreProvider.of<AppState>(context).dispatch(SavePostContentAction(_post, '1'));
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('발행'),
              onPressed: () {
                StoreProvider.of<AppState>(context).dispatch(SavePostContentAction(_post, '3'));
                Navigator.pop(context);
              },
            ),
          ],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: '제목을 입력하세요.',
                  labelText: '제목',
                  focusedBorder: OutlineInputBorder(),
                  border: OutlineInputBorder()
                ),
                maxLines: 1,
                controller: _titleController,
              ),
              _CategorySelect(_post.categoryId, (categoryId) {
                _post.categoryId = categoryId;
              }),
            ],
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_post.title),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _showPublishDialog(context),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: TextField(
                maxLines: 100,
                controller: _contentController
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CategorySelect extends StatefulWidget {
  String _categoryId;
  Function _onSelect;

  _CategorySelect(this._categoryId, this._onSelect);

  @override
  State<StatefulWidget> createState() {
    return _CategorySelectState(_categoryId, _onSelect);
  }
}

class _CategorySelectState extends State<_CategorySelect> {
  String _categoryId;
  Function _onSelect;

  _CategorySelectState(this._categoryId, this._onSelect);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Category>>(
      converter: (store) => store.state.selectedBlog.categories,
      builder: (context, categories) {
        var categoryItems = categories.map((c) => DropdownMenuItem(
          child: Text(c.name),
          value: c.id,
        )).toList();

        categoryItems.insert(0, DropdownMenuItem(
            child: Text('카테고리 없음'),
            value: '0'
        ));

        return DropdownButton(
          hint: Text('카테고리'),
          value: _categoryId,
          items: categoryItems,
          onChanged: (categoryId) {
            setState(() {
              _categoryId = categoryId;
            });
            _onSelect(categoryId);
          },
        );
      },
    );
  }

}