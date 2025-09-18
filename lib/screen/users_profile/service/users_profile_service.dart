import 'dart:convert';
import 'package:bunyo/screen/users_profile/model/users_profile_model.dart';
import 'package:bunyo/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<UserProfileModel> getUser(int userId) async {
    final response = await http.get(
      Uri.parse(postUrl + '/users' + '/${userId.toString()}'),

      headers: headers,
    );

    dynamic user = jsonDecode(response.body);

    UserProfileModel userModel = UserProfileModel.fromJson(user);

    return userModel;
  }
}
