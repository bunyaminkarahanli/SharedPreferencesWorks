import 'dart:convert';
import 'package:bunyo/screen/post_detail/model/post_detail_model.dart';

import 'package:bunyo/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<PostDetailModel> getPost() async {

    final response = await http.get(Uri.parse(postUrl + "/10"),headers: headers,);

    dynamic post = jsonDecode(response.body);

    PostDetailModel postModel = PostDetailModel.fromJson(post);

    return postModel;
  }
}
