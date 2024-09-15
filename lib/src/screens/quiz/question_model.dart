import 'dart:convert';

class QuestionModel {
  String? question;
  List<String>? options;

  QuestionModel({
    this.question,
    this.options,
  });

  QuestionModel copyWith({
    String? question,
    List<String>? options,
  }) =>
      QuestionModel(
        question: question ?? this.question,
        options: options ?? this.options,
      );

  factory QuestionModel.fromJson(String str) =>
      QuestionModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromMap(Map<String, dynamic> json) => QuestionModel(
        question: json["question"],
        options: json["options"] == null
            ? []
            : List<String>.from(json["options"]!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "question": question,
        "options":
            options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
      };
}
