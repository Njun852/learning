import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef CloseDialog = void Function();

CloseDialog showLoadingDialog({
  required BuildContext context,
  required String text,
}) {
  final dialog = AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(
          height: 10,
        ),
        Text(text),
      ],
    ),
  );

  showDialog(
    context: context,
    barrierDismissible:
        false, //don't allow user to tap out of the loading screen
    builder: (context) => dialog,
  );
  return () => Navigator.of(context).pop();
}
