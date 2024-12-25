import 'package:flutter/material.dart';

class SnackBarSmsService {
  static final GlobalKey<ScaffoldMessengerState> messengerKey =
  GlobalKey<ScaffoldMessengerState>();

  static void showSnackBar(String message) {
    final messenger = messengerKey.currentState;
    if (messenger != null) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      debugPrint('ScaffoldMessengerState is null. Ensure the messengerKey is properly initialized.');
    }
  }
}
