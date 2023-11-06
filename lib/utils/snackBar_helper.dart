import 'package:flutter/material.dart';
import 'package:todo_list/constants/colors.dart';

void showErrorMessage(
  BuildContext context, {
  required String message,
}) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: TextStyle(color: tdBgColor),
    ),
    backgroundColor: tdRed,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

// API response reaction
void showSuccessMessage(
  BuildContext context, {
  required String message,
}) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: TextStyle(color: tdBgColor),
    ),
    backgroundColor: tdBlue,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
