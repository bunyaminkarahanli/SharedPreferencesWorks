import 'dart:convert';
import 'package:bunyo/screen/post_detail/model/comments_detail_model.dart';
import 'package:bunyo/screen/post_detail/model/post_detail_model.dart';
import 'package:bunyo/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<PostDetailModel> getPost(int postId) async {
    final response = await http.get(
      Uri.parse(postUrl + '/posts' + '/${postId.toString()}'),

      headers: headers,
    );

    dynamic post = jsonDecode(response.body);

    PostDetailModel postModel = PostDetailModel.fromJson(post);

    return postModel;
  }

  Future<List<CommentsDetailModel>> getComments(int postId) async {
    final response = await http.get( Uri.parse(postUrl + '/posts' + '/${postId.toString()}' + '/comments' ),headers: headers,
    );
    
    List<dynamic> responseList = jsonDecode(response.body);
    List<CommentsDetailModel> comments = [];
    for (var i = 0; i < responseList.length; i++) {
      comments.add(CommentsDetailModel.fromJson(responseList[i]));
    }

    return comments;
  }

}