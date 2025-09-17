import 'package:bunyo/screen/post_detail/model/post_detail_model.dart';
import 'package:bunyo/screen/post_detail/service/post_detail_service.dart';
import 'package:flutter/material.dart';

class PostDetail extends StatefulWidget {
  final int postId;

  const PostDetail({super.key, required this.postId});

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  ApiService service = ApiService();
  PostDetailModel? post;

  @override
  void initState() {
    super.initState();
    fetchPost();
  }

  void fetchPost() async {
    PostDetailModel data = await service.getPost();
    setState(() {
      post = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (post == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(),
      body: InkWell(
        child: Column(
          children: [
            Center(
              child: Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Title:\n${post!.title}"),
                      SizedBox(height: 10),
                      Text("Body:\n${post!.body}"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
