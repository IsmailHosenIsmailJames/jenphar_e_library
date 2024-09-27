import 'dart:convert';

class QuestionModel {
  int id;
  int quizId;
  String question;
  String? option1;
  String? option2;
  String? option3;
  String? option4;
  String answer;
  DateTime createdAt;
  DateTime? updatedAt;
  int? timeDuration;

  QuestionModel({
    required this.id,
    required this.quizId,
    required this.question,
    this.option1,
    this.option2,
    this.option3,
    this.option4,
    required this.answer,
    required this.createdAt,
    required this.updatedAt,
    this.timeDuration,
  });

  QuestionModel copyWith({
    int? id,
    int? quizId,
    String? question,
    String? option1,
    String? option2,
    String? option3,
    String? option4,
    String? answer,
    DateTime? createdAt,
    dynamic updatedAt,
    int? timeDuration,
  }) =>
      QuestionModel(
        id: id ?? this.id,
        quizId: quizId ?? this.quizId,
        question: question ?? this.question,
        option1: option1 ?? this.option1,
        option2: option2 ?? this.option2,
        option3: option3 ?? this.option3,
        option4: option4 ?? this.option4,
        answer: answer ?? this.answer,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        timeDuration: timeDuration ?? this.timeDuration,
      );

  factory QuestionModel.fromJson(String str) =>
      QuestionModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromMap(Map<String, dynamic> json) => QuestionModel(
        id: json["id"],
        quizId: json["quiz_id"],
        question: json["question"],
        option1: json["option_1"],
        option2: json["option_2"],
        option3: json["option_3"],
        option4: json["option_4"],
        answer: json["answer"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        timeDuration: json["time_duration"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "quiz_id": quizId,
        "question": question,
        "option_1": option1,
        "option_2": option2,
        "option_3": option3,
        "option_4": option4,
        "answer": answer,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "time_duration": timeDuration,
      };
}
