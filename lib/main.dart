import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter_test/data/model/post.dart';
import 'package:new_flutter_test/data/repository/post_repository.dart';

import 'bloc/post/post_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<PostBloc>(
        create: (context) => PostBloc(PostRepositoryImpl())..add(FetchPosts()),
        child: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Posts"),
      ),
      body: Center(
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoading) {
              return CircularProgressIndicator();
            } else if (state is PostLoaded) {
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, i) {
                  return ListTile(title: Text(state.posts[i].title ?? 'Null'));
                },
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
