import 'dart:convert';

class QuizResultsModel {
  bool? success;
  List<Datum>? data;

  QuizResultsModel({
    this.success,
    this.data,
  });

  QuizResultsModel copyWith({
    bool? success,
    List<Datum>? data,
  }) =>
      QuizResultsModel(
        success: success ?? this.success,
        data: data ?? this.data,
      );

  factory QuizResultsModel.fromJson(String str) =>
      QuizResultsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory QuizResultsModel.fromMap(Map<String, dynamic> json) =>
      QuizResultsModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Datum {
  int? userId;
  int? quizId;
  String? quizName;
  int? totalPoints;
  String? totalMarks;

  Datum({
    this.userId,
    this.quizId,
    this.quizName,
    this.totalPoints,
    this.totalMarks,
  });

  Datum copyWith({
    int? userId,
    int? quizId,
    String? quizName,
    int? totalPoints,
    String? totalMarks,
  }) =>
      Datum(
        userId: userId ?? this.userId,
        quizId: quizId ?? this.quizId,
        quizName: quizName ?? this.quizName,
        totalPoints: totalPoints ?? this.totalPoints,
        totalMarks: totalMarks ?? this.totalMarks,
      );

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        userId: json["user_id"],
        quizId: json["quiz_id"],
        quizName: json["quiz_name"],
        totalPoints: json["total_points"],
        totalMarks: json["total_marks"],
      );

  Map<String, dynamic> toMap() => {
        "user_id": userId,
        "quiz_id": quizId,
        "quiz_name": quizName,
        "total_points": totalPoints,
        "total_marks": totalMarks,
      };
}
