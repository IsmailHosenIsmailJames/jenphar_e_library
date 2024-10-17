import 'dart:convert';

class LeaderBoardModel {
  bool? success;
  List<Leaderboard>? leaderboard;

  LeaderBoardModel({
    this.success,
    this.leaderboard,
  });

  LeaderBoardModel copyWith({
    bool? success,
    List<Leaderboard>? leaderboard,
  }) =>
      LeaderBoardModel(
        success: success ?? this.success,
        leaderboard: leaderboard ?? this.leaderboard,
      );

  factory LeaderBoardModel.fromJson(String str) =>
      LeaderBoardModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LeaderBoardModel.fromMap(Map<String, dynamic> json) =>
      LeaderBoardModel(
        success: json["success"],
        leaderboard: json["leaderboard"] == null
            ? []
            : List<Leaderboard>.from(
                json["leaderboard"]!.map((x) => Leaderboard.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "leaderboard": leaderboard == null
            ? []
            : List<dynamic>.from(leaderboard!.map((x) => x.toMap())),
      };
}

class Leaderboard {
  String? workAreaT;
  String? userName;
  String? totalMarks;

  Leaderboard({
    this.workAreaT,
    this.userName,
    this.totalMarks,
  });

  Leaderboard copyWith({
    String? workAreaT,
    String? userName,
    String? totalMarks,
  }) =>
      Leaderboard(
        workAreaT: workAreaT ?? this.workAreaT,
        userName: userName ?? this.userName,
        totalMarks: totalMarks ?? this.totalMarks,
      );

  factory Leaderboard.fromJson(String str) =>
      Leaderboard.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Leaderboard.fromMap(Map<String, dynamic> json) => Leaderboard(
        workAreaT: json["work_area_t"],
        userName: json["user_name"],
        totalMarks: json["total_marks"],
      );

  Map<String, dynamic> toMap() => {
        "work_area_t": workAreaT,
        "user_name": userName,
        "total_marks": totalMarks,
      };
}
