import 'package:bunyo/screen/users_profile/model/users_profile_model.dart';
import 'package:bunyo/screen/users_profile/service/users_profile_service.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  final int userId;
  const UserProfilePage({super.key, required this.userId});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  ApiService service = ApiService();

  UserProfileModel? user;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    UserProfileModel data = await service.getUser(widget.userId);
    setState(() {
      user = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${user?.name ?? ''}'),
            Text('Username: ${user?.username ?? ''}'),
            Text('City: ${user?.address?.city ?? ''}'),
            Text('Website: ${user?.website ?? ''}'),
            Text('Email: ${user?.email ?? ''}'),
          ],
        ),
      ),
    );
  }
}
