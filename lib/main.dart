import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tistory_editor/middleware/middlewares.dart';
import 'package:tistory_editor/screens/index.dart';
import 'package:tistory_editor/screens/post_edit.dart';
import 'package:tistory_editor/screens/post_list.dart';
import 'package:tistory_editor/screens/post_view.dart';
import 'package:tistory_editor/screens/tistory_auth.dart';
import 'package:tistory_editor/reducers/app_reducer.dart';


void main() {
  final store = new Store<AppState>(
    appStateReducer,
    initialState: AppState.newEmptyInstance(),
    middleware: createMiddleware()
  );

  runApp(TistoryEditorApp(store));
}

class TistoryEditorApp extends StatelessWidget {
  final Store<AppState> _store;

  TistoryEditorApp(Store<AppState> store): _store = store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: _store,
      child: MaterialApp(
        title: 'Editor for Tistory',
        theme: ThemeData.light(),
        initialRoute: '/',
        routes: {
          '/': (context) => IndexScreen(),
          '/post/list': (context) => PostListScreen(),
          '/post/view': (context) => PostViewScreen(),
          '/post/edit': (context) => PostEditScreen(),
          '/auth/tistory': (context) => TistoryAuthScreen()
        },
      ),
    );
  }
}
