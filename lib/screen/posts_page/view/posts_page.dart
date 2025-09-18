import 'package:bunyo/screen/post_detail/view/post_detail_page.dart';
import 'package:bunyo/screen/posts_page/models/comments_model.dart';
import 'package:bunyo/screen/posts_page/services/posts_detail_service.dart';
import 'package:flutter/material.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final ApiService service = ApiService();
  List<PostsModel>? _posts; // null => henüz yüklenmedi

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  Future<void> _fetchComments() async {
    final List<PostsModel> data = await service.getPosts();
    setState(() {
      _posts = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_posts == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Posts")),
      body: ListView.builder(
        itemCount: _posts!.length,
        itemBuilder: (context, index) {
          final PostsModel post = _posts![index];
          return InkWell(
            onTap: () {
              goPostDetail(context, post);
            },
            child: Card(
              margin: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Title:\n${post.title}"),
                    SizedBox(height: 10),
                    Text("Body:\n${post.body}"),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void goPostDetail(BuildContext context, PostsModel post) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PostDetail(postId: post.id!)),
    );
  }
}
