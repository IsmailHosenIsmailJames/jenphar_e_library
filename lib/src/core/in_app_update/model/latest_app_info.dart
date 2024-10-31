import 'dart:convert';

class LatestAppInfoAPIModel {
  String? version;
  bool? forceToUpdate;
  List<DownloadLinkList>? downloadLinkList;

  LatestAppInfoAPIModel({
    this.version,
    this.forceToUpdate,
    this.downloadLinkList,
  });

  LatestAppInfoAPIModel copyWith({
    String? version,
    bool? forceToUpdate,
    List<DownloadLinkList>? downloadLinkList,
  }) =>
      LatestAppInfoAPIModel(
        version: version ?? this.version,
        forceToUpdate: forceToUpdate ?? this.forceToUpdate,
        downloadLinkList: downloadLinkList ?? this.downloadLinkList,
      );

  factory LatestAppInfoAPIModel.fromJson(String str) =>
      LatestAppInfoAPIModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LatestAppInfoAPIModel.fromMap(Map<String, dynamic> json) =>
      LatestAppInfoAPIModel(
        version: json["version"],
        forceToUpdate: json["forceToUpdate"],
        downloadLinkList: json["downloadLinkList"] == null
            ? []
            : List<DownloadLinkList>.from(json["downloadLinkList"]!
                .map((x) => DownloadLinkList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "version": version,
        "forceToUpdate": forceToUpdate,
        "downloadLinkList": downloadLinkList == null
            ? []
            : List<dynamic>.from(downloadLinkList!.map((x) => x.toMap())),
      };
}

class DownloadLinkList {
  String? architecture;
  String? link;

  DownloadLinkList({
    this.architecture,
    this.link,
  });

  DownloadLinkList copyWith({
    String? architecture,
    String? link,
  }) =>
      DownloadLinkList(
        architecture: architecture ?? this.architecture,
        link: link ?? this.link,
      );

  factory DownloadLinkList.fromJson(String str) =>
      DownloadLinkList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DownloadLinkList.fromMap(Map<String, dynamic> json) =>
      DownloadLinkList(
        architecture: json["architecture"],
        link: json["link"],
      );

  Map<String, dynamic> toMap() => {
        "architecture": architecture,
        "link": link,
      };
}
