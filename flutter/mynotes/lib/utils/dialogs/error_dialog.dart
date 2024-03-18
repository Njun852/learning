import 'package:mynotes/utils/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(context, errorMessage) {
  return showGenericDialog<void>(
    context: context,
    title: 'An error occurred',
    content: errorMessage,
    optionBuilder: () => {'Okay': null},
  );
}
