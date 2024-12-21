import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:bytesoles/detail_product/models/comment.dart';

class CommentService {
  final CookieRequest request;
  final String baseUrl;

  CommentService({
    required this.request,
    required this.baseUrl,
  });

  Future<List<CommentsEntry>> getComments(String productId) async {
    try {
      final response = await request
          .get('$baseUrl/detail_product/product/$productId/comments/');

      if (response is List) {
        return response.map((json) => CommentsEntry.fromJson(json)).toList();
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      throw Exception('Failed to load comments: $e');
    }
  }

  Future<void> addComment(String productId, String content) async {
    if (!request.loggedIn) {
      throw Exception('User must be logged in to comment');
    }

    try {
      await request.post(
        '$baseUrl/detail_product/products/$productId/add_comment/',
        {
          'content': content,
        },
      );
    } catch (e) {
      throw Exception('Failed to add comment: $e');
    }
  }
}
