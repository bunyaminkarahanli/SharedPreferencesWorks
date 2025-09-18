import 'package:bunyo/screen/post_detail/model/comments_detail_model.dart';
import 'package:bunyo/screen/post_detail/model/post_detail_model.dart';
import 'package:bunyo/screen/post_detail/service/post_detail_service.dart';
import 'package:bunyo/screen/users_profile/view/user_profile_page.dart';
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

  List<CommentsDetailModel> comments = [];

  @override
  void initState() {
    super.initState();
    fetchPost();
  }

  Future<void> fetchPost() async {
    PostDetailModel data = await service.getPost(widget.postId);
    setState(() {
      post = data;
    });
  }

  Future<void> fetchComments() async {
    final data = await service.getComments(widget.postId);
    setState(() {
      comments = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (post == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: Text('${post!.title}')),
      body: Column(
        children: [
          Center(
            child: InkWell(
              onTap: () {
                fetchComments();
              },
              child: Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Title: ${post!.title}\n'),
                      Text("Body:${post!.body}"),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  showUserDialog(context, post?.userId ?? 0);
                },
                child: Text('Profil'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    comments = [];
                  });
                },
                child: Text('Temizle'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final c = comments[index];
                return ListTile(
                  title: Text('${c.name}'),
                  subtitle: Text('${c.body}'),
                  trailing: Text('${c.email}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showUserDialog(BuildContext context, int userId) {
    return showDialog(
      context: context,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 300,
            maxHeight: MediaQuery.of(context).size.height * 0.40,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: UserProfilePage(userId: userId),
          ),
        ),
      ),
    );
  }
}
