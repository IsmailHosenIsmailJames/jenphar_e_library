import 'package:dio/dio.dart';

import '../../../api/apis.dart';
import '../model/latest_app_info.dart';

Future<LatestAppInfoAPIModel> getInfoFormAPI() async {
  final response = await Dio().get("$apiBase/app/get_latest_app_info");
  if (response.statusCode == 200) {
    try {
      Map<String, dynamic> data = Map<String, dynamic>.from(response.data);
      return LatestAppInfoAPIModel.fromMap(data['result']);
    } catch (e) {
      throw Exception('Failed to get latest app info');
    }
  } else {
    throw Exception('Failed to get latest app info');
  }
}
