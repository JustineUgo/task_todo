import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

enum ToastType { success, error, info }

class UIService {
  void showToast({required String text, required ToastType type}) {
    toastification.show(
      type: type == ToastType.info
          ? ToastificationType.info
          : (type == ToastType.success)
              ? ToastificationType.success
              : ToastificationType.error,
      title: Text(text),
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 2),
    );
  }
}
