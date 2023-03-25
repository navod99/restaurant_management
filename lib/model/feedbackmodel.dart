// To parse this JSON data,

//     final feedback = feedbackFromJson(jsonString);

import 'dart:convert';

Feedback feedbackFromJson(String str) => Feedback.fromJson(json.decode(str));

String feedbackToJson(Feedback data) => json.encode(data.toJson());

class Feedback {
  Feedback({
    this.id,
    required this.category,
    required this.description,
  });

  String? id;
  final String category;
  final String description;

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
        id: json["id"],
        category: json["category"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "description": description,
      };
}
