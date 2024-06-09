
import 'package:flutter/material.dart';
import 'package:tasky/core/widget/app_snack_bar.dart';
final navigatorKey = GlobalKey<NavigatorState>();


enum MassageType {
  success,
  failed,
  warning,
}

enum ProductType {
  favorite,
  custom,
  category,
}

enum PaymentType { cash, visa, mastercard }

void showMessage({
  required String message,
  MassageType type = MassageType.failed,
}) {
  debugPrint('message is $message');
  if (message.isNotEmpty) {
    backgroundColor: type == MassageType.success?
        SnackBarApp.success(navigatorKey.currentContext!, text: message):
        type == MassageType.failed?
        SnackBarApp(navigatorKey.currentContext!, text: message, text2: ''):
SnackBarApp.required(navigatorKey.currentContext!, text: message, text2: '');

  }
}

MaterialColor? primarySwatch() {
  Color color = const Color(0xFF5F33E1);
  return MaterialColor(color.value, {
    50: color.withOpacity(0.1),
    100: color.withOpacity(0.2),
    200: color.withOpacity(0.3),
    300: color.withOpacity(0.4),
    400: color.withOpacity(0.5),
    500: color.withOpacity(0.6),
    600: color.withOpacity(0.7),
    700: color.withOpacity(0.8),
    800: color.withOpacity(0.9),
    900: color.withOpacity(1.0),
  });
}
