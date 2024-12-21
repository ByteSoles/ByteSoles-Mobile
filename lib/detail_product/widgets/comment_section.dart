import 'package:bytesoles/detail_product/models/comment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class CommentSection extends StatefulWidget {
  final String productSlug;

  const CommentSection({
    Key? key,
    required this.productSlug,
  }) : super(key: key);

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final _commentController = TextEditingController();
  List<CommentsEntry> _comments = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  Future<void> _loadComments() async {
    setState(() => _isLoading = true);
    try {
      final request = context.read<CookieRequest>();
      final response = await request.get(
          'http://127.0.0.1:8000/detail_product/product/${widget.productSlug}/comments/');

      // Ensure response is a List
      if (response is! List) {
        throw Exception('Expected List but got ${response.runtimeType}');
      }

      // Convert each item and print for debugging
      _comments = response.map((item) {
        try {
          return CommentsEntry.fromJson(item);
        } catch (e) {
          print('Error processing item: $e');
          rethrow;
        }
      }).toList();

      setState(() {});
    } catch (e) {
      print('Error in _loadComments: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load comments: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _submitComment() async {
    if (_commentController.text.isEmpty) return;

    try {
      final request = context.read<CookieRequest>();

      // Debug prints nyerah dulu bang
      print("=== Flutter Debug Info ===");
      print('Login status: ${request.loggedIn}');
      print('Cookies: ${request.cookies}');
      print('Headers: ${request.headers}');
      print("=========================");

      if (!request.loggedIn) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please log in to comment')),
        );
        return;
      }

      final response = await request.post(
        'http://127.0.0.1:8000/detail_product/product/${widget.productSlug}/add_comment/',
        {
          'content': _commentController.text,
        },
      );

      print('Response from server: $response');

      if (response is Map<String, dynamic>) {
        if (response['status'] == 'success') {
          _commentController.clear();
          await _loadComments();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Comment added successfully')),
          );
        } else {
          throw Exception(response['message'] ?? 'Unknown error');
        }
      }
    } catch (e) {
      print('Error details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add comment: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Comments',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (_isLoading)
          const Center(child: CircularProgressIndicator())
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _comments.length,
            itemBuilder: (context, index) {
              final comment = _comments[index];
              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            comment.user,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat('MMM d, yyyy').format(comment.createdAt),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(comment.content),
                    ],
                  ),
                ),
              );
            },
          ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                    hintText: 'Add a comment...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: _submitComment,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
