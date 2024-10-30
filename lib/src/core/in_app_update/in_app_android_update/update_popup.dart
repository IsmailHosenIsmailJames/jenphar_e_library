import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jenphar_e_library/src/core/functions/show_towast.dart';
import 'package:jenphar_e_library/src/core/in_app_update/in_app_android_update/popup_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toastification/toastification.dart';

import '../../../../main.dart';
import '../model/latest_app_info.dart';

Future<void> showUpdatePopup(
  BuildContext context, {
  required LatestAppInfoAPIModel latestAppInfoAPIModel,
  required String currentVersion,
  required String apkDownloadLink,
}) async {
  Directory directory = await getApplicationCacheDirectory();
  String filePath =
      '${directory.path}/apk-${latestAppInfoAPIModel.version}.apk';

  final isExitsSameVersionAPK = await File(filePath).exists();

  final apkInstallPermission = await Permission.requestInstallPackages.status;

  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopupWidget(
            latestAppInfoAPIModel: latestAppInfoAPIModel,
            currentAppVersion: currentVersion,
            apkDownloadLink: apkDownloadLink,
            isExitsSameVersionAPK: isExitsSameVersionAPK,
            apkInstallPermission: apkInstallPermission,
          )).then(
    (value) {
      isUpdateChecked = true;
      if (latestAppInfoAPIModel.forceToUpdate == true) {
        showToastNotification(
          msg: "Can't continue with this update",
          context: context,
          type: ToastificationType.error,
        );
        SystemNavigator.pop(animated: true);
      }
    },
  );
}
