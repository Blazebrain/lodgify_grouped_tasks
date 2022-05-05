import 'package:flutter/material.dart';
import 'package:lodgify/app/app.locator.dart';
import 'package:lodgify/utils/enums.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> setupSnackBarUI() async {
  await locator.allReady();
  final service = locator<SnackbarService>();

  // Registers a config to be used when calling showSnackbar
  service.registerCustomSnackbarConfig(
    variant: SnackbarType.success,
    config: SnackbarConfig(
      backgroundColor: Colors.green.shade600,
      overlayColor: Colors.green.shade600,
      textColor: Colors.white,
      snackPosition: SnackPosition.TOP,
      animationDuration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      borderRadius: 16.0,
      icon: const Icon(
        Icons.info,
        color: Colors.white,
        size: 20,
      ),
    ),
  );

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.error,
    config: SnackbarConfig(
      backgroundColor: Colors.red.shade600,
      textColor: Colors.white,
      snackPosition: SnackPosition.TOP,
      overlayColor: Colors.red.shade600,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      borderRadius: 16.0,
      animationDuration: const Duration(milliseconds: 500),
      icon: const Icon(
        Icons.info,
        color: Colors.white,
        size: 20,
      ),
    ),
  );
}
