import 'package:flutter/material.dart';

primarySnackBar({
  required BuildContext context,
  required String text,
  required CustomSnack priority,
}) {
  getBackgroundColor(priority) {
    switch (priority) {
      case CustomSnack.SUCCESS:
        return const Color(0xff1aa66c);
      case CustomSnack.WARNING:
        return const Color(0xffdca722);
      case CustomSnack.ERROR:
        return const Color(0xffdb4661);
    }
  }

  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 2),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(12),
    content: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontFamily: 'DMSans',
      ),
    ),
    backgroundColor: getBackgroundColor(priority),
  ));
}

enum CustomSnack { WARNING, SUCCESS, ERROR }
