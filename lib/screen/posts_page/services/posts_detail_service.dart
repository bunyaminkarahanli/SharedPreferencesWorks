import 'dart:convert';
import 'package:bunyo/utils/constants/api_constants.dart';
import 'package:bunyo/screen/posts_page/models/comments_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<PostsModel>> getPosts() async {
    final response = await http.get(Uri.parse(postUrl +'/posts'),
      headers: headers,
    );

    List<PostsModel> posts = [];
    List<dynamic> responseList = jsonDecode(response.body);

    for (var i = 0; i < responseList.length; i++) {
      posts.add(PostsModel.fromJson(responseList[i]));
    }

    return posts;
  }
}
