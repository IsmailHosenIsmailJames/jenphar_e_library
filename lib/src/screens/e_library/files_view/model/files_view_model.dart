import 'dart:convert';

class FilesViewModel {
  int? id;
  int? brandId;
  String? file;
  FileType? fileType;
  Type? type;
  int? status;
  DateTime? createdAt;

  FilesViewModel({
    this.id,
    this.brandId,
    this.file,
    this.fileType,
    this.type,
    this.status,
    this.createdAt,
  });

  FilesViewModel copyWith({
    int? id,
    int? brandId,
    String? file,
    FileType? fileType,
    Type? type,
    int? status,
    DateTime? createdAt,
  }) =>
      FilesViewModel(
        id: id ?? this.id,
        brandId: brandId ?? this.brandId,
        file: file ?? this.file,
        fileType: fileType ?? this.fileType,
        type: type ?? this.type,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );

  factory FilesViewModel.fromJson(String str) =>
      FilesViewModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FilesViewModel.fromMap(Map<String, dynamic> json) => FilesViewModel(
        id: json["id"],
        brandId: json["brand_id"],
        file: json["file"],
        fileType: fileTypeValues.map[json["file_type"]]!,
        type: typeValues.map[json["type"]]!,
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "brand_id": brandId,
        "file": file,
        "file_type": fileTypeValues.reverse[fileType],
        "type": typeValues.reverse[type],
        "status": status,
        "created_at": createdAt?.toIso8601String(),
      };
}

enum FileType { PDF }

final fileTypeValues = EnumValues({"pdf": FileType.PDF});

enum Type { RESULT }

final typeValues = EnumValues({"result": Type.RESULT});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
