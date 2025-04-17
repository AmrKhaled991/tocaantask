
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

Future<void> showErrorSnackBar({
  required BuildContext context,
  required String message,
}) async {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.error(
      message: message,
      backgroundColor: Colors.red.shade700,
    ),
  );
}
