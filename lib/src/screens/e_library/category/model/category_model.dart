import 'dart:convert';

class CategoryModel {
  int? id;
  String? category;
  String? medicineName;
  String? brandLogo;
  int? status;
  DateTime? createdAt;
  dynamic updatedAt;

  CategoryModel({
    this.id,
    this.category,
    this.medicineName,
    this.brandLogo,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  CategoryModel copyWith({
    int? id,
    String? category,
    String? medicineName,
    String? brandLogo,
    int? status,
    DateTime? createdAt,
    dynamic updatedAt,
  }) =>
      CategoryModel(
        id: id ?? this.id,
        category: category ?? this.category,
        medicineName: medicineName ?? this.medicineName,
        brandLogo: brandLogo ?? this.brandLogo,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory CategoryModel.fromJson(String str) =>
      CategoryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromMap(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        category: json["category"],
        medicineName: json["medicine_name"],
        brandLogo: json["brand_logo"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "category": category,
        "medicine_name": medicineName,
        "brand_logo": brandLogo,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt,
      };
}
