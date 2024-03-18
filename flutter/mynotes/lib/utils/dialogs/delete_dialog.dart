import 'package:mynotes/utils/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Confirm Delete',
    content: 'Are you sure you want to delete this item?',
    optionBuilder: () => {
      'No': false,
      'Yes': true,
    },
  ).then((value) => value ?? false);
}
