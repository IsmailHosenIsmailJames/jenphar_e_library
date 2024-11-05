import 'dart:convert';

class LoginResponseModel {
  int id;
  String workAreaT;
  String userName;
  String password;
  DateTime? createdAt;
  DateTime? updatedAt;

  LoginResponseModel({
    required this.id,
    required this.workAreaT,
    required this.userName,
    required this.password,
    this.createdAt,
    this.updatedAt,
  });

  LoginResponseModel copyWith({
    int? id,
    String? workAreaT,
    String? userName,
    String? password,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      LoginResponseModel(
        id: id ?? this.id,
        workAreaT: workAreaT ?? this.workAreaT,
        userName: userName ?? this.userName,
        password: password ?? this.password,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory LoginResponseModel.fromJson(String str) =>
      LoginResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginResponseModel.fromMap(Map<String, dynamic> json) =>
      LoginResponseModel(
        id: json["id"],
        workAreaT: json["work_area_t"],
        userName: json["user_name"],
        password: json["password"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "work_area_t": workAreaT,
        "user_name": userName,
        "password": password,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
