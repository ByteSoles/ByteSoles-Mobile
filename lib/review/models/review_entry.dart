// To parse this JSON data, do
//
//     final reviewEntry = reviewEntryFromJson(jsonString);

import 'dart:convert';

List<ReviewEntry> reviewEntryFromJson(String str) => List<ReviewEntry>.from(json.decode(str).map((x) => ReviewEntry.fromJson(x)));

String reviewEntryToJson(List<ReviewEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReviewEntry {
    String model;
    int pk;
    Fields fields;

    ReviewEntry({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory ReviewEntry.fromJson(Map<String, dynamic> json) => ReviewEntry(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int user;
    String username;
    int sneaker;
    DateTime date;
    String reviewDescription;
    int score;

    Fields({
        required this.user,
        required this.username,
        required this.sneaker,
        required this.date,
        required this.reviewDescription,
        required this.score,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        username: json["username"],
        sneaker: json["sneaker"],
        date: DateTime.parse(json["date"]),
        reviewDescription: json["review_description"],
        score: json["score"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "username": username,
        "sneaker": sneaker,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "review_description": reviewDescription,
        "score": score,
    };
}
