

import 'dart:convert';

import 'package:http/http.dart';
import 'package:new_flutter_test/data/model/post.dart';

abstract class PostRepository{
  Future<List<Post>> getPosts();
}

class PostRepositoryImpl extends PostRepository {

  @override
  Future<List<Post>> getPosts() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await get(url);
    if(response.statusCode == 200){
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Post>((item) => Post.fromJson(item)).toList();
    }else{
      throw Exception("Can't load posts");
    }
  }

}