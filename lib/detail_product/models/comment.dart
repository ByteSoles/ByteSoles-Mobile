// To parse this JSON data, do
//
//     final commentsEntry = commentsEntryFromJson(jsonString);

import 'dart:convert';

List<CommentsEntry> commentsEntryFromJson(String str) =>
    List<CommentsEntry>.from(
        json.decode(str).map((x) => CommentsEntry.fromJson(x)));

String commentsEntryToJson(List<CommentsEntry> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommentsEntry {
  String user;
  String content;
  DateTime createdAt;

  CommentsEntry({
    required this.user,
    required this.content,
    required this.createdAt,
  });

  factory CommentsEntry.fromJson(Map<String, dynamic> json) => CommentsEntry(
        user: json["user"],
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "content": content,
        "created_at": createdAt.toIso8601String(),
      };
}
