import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../api/apis.dart';
import '../model/latest_app_info.dart';

Future<LatestAppInfoAPIModel> getInfoFormAPI() async {
  log("$apiBase/api/app/latest_info");
  final response = await Dio().get("$apiBase/api/app/latest_info");
  if (response.statusCode == 200) {
    try {
      Map<String, dynamic> data = Map<String, dynamic>.from(response.data);
      return LatestAppInfoAPIModel.fromMap(data);
    } catch (e) {
      throw Exception('Failed to get latest app info');
    }
  } else {
    throw Exception('Failed to get latest app info');
  }
}
