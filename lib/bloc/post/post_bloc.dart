import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_flutter_test/data/model/post.dart';
import 'package:new_flutter_test/data/repository/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;

  PostBloc(this.repository) : super(PostInitial());

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if(event is FetchPosts){
      yield PostLoading();
      try{
        final posts = await repository.getPosts();
        yield PostLoaded(posts);
      }catch(e){
        yield PostError(e.toString());
      }
    }
  }
}
