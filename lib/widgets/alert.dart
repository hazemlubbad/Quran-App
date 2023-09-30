import 'package:flutter/material.dart';

void showSnackBar(BuildContext context,
    {required String message, bool error = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: error ? Colors.red : Colors.black,
      duration: const Duration(seconds: 2),
      dismissDirection: DismissDirection.horizontal,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
    ),
  );
}
