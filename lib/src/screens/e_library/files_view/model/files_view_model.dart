import 'dart:convert';

class FilesViewModel {
  int? id;
  int? brandId;
  String? file;
  String? fileType;
  String? type;
  int? status;
  String? createdAt;

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
    String? fileType,
    String? type,
    int? status,
    String? createdAt,
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
        fileType: json["file_type"],
        type: json["type"],
        status: json["status"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "brand_id": brandId,
        "file": file,
        "file_type": fileType,
        "type": type,
        "status": status,
        "created_at": createdAt,
      };
}
