import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:tistory_editor/actions/actions.dart';
import 'package:tistory_editor/models/post.dart';
import 'package:tistory_editor/reducers/app_reducer.dart';
import 'package:tistory_editor/services/tistory_content.dart';

class PostViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SelectedPost>(
      converter: (store) => store.state.selectedPost,
      builder: (context, post) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: post != null ? Text(post.post.title) : null,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/post/edit');
                },
              )
            ],
          ),
          body: post != null ? PostViewWidget() : Text('로딩 중'),
        );
      },
      onInit: (store) {
        store.dispatch(LoadPostContentAction());
      },
    );
  }
}

class PostViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SelectedPost>(
      converter: (store) => store.state.selectedPost,
      builder: (context, post) {
        if (post.content.length == 0) {
          return Text('로딩 중');
        }

        return WebviewScaffold(
          url: Uri.dataFromString(
            convertAttachmentUrl(post.content),
            mimeType: 'text/html',
            encoding: Utf8Codec(allowMalformed: true),
          ).toString(),
          allowFileURLs: false,
          withZoom: true,
          hidden: true,
        );
      }
    );
  }
}
