import 'package:flutter/material.dart';
import 'package:fluvie/resource/styles/dimens.dart';

class ErrorMessageSnackbar {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red[400],
      padding: const EdgeInsets.all(Dimens.spacingLarge),
      dismissDirection: DismissDirection.down,
    ));
  }
}
