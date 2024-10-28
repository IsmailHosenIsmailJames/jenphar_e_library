import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showToastNotification({
  required BuildContext context,
  required String msg,
  required ToastificationType type,
}) {
  toastification.show(
    context: context,
    title: Text(msg),
    autoCloseDuration: const Duration(seconds: 5),
    type: type,
  );
}
