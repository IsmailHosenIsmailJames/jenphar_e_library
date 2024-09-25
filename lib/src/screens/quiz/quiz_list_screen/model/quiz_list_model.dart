import 'dart:convert';

class QuizListModel {
  int id;
  String name;
  int timeDuration;
  int totalPoints;
  String category;
  DateTime startTime;
  DateTime endTime;
  String status;
  DateTime createdAt;
  dynamic updatedAt;

  QuizListModel({
    required this.id,
    required this.name,
    required this.timeDuration,
    required this.totalPoints,
    required this.category,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  QuizListModel copyWith({
    int? id,
    String? name,
    int? timeDuration,
    int? totalPoints,
    String? category,
    DateTime? startTime,
    DateTime? endTime,
    String? status,
    DateTime? createdAt,
    dynamic updatedAt,
  }) =>
      QuizListModel(
        id: id ?? this.id,
        name: name ?? this.name,
        timeDuration: timeDuration ?? this.timeDuration,
        totalPoints: totalPoints ?? this.totalPoints,
        category: category ?? this.category,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory QuizListModel.fromJson(String str) =>
      QuizListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory QuizListModel.fromMap(Map<String, dynamic> json) => QuizListModel(
        id: json["id"],
        name: json["name"],
        timeDuration: json["time_duration"],
        totalPoints: json["total_points"],
        category: json["category"],
        startTime: DateTime.parse(json["start_time"]),
        endTime: DateTime.parse(json["end_time"]),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "time_duration": timeDuration,
        "total_points": totalPoints,
        "category": category,
        "start_time": startTime.toIso8601String(),
        "end_time": endTime.toIso8601String(),
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
      };
}
