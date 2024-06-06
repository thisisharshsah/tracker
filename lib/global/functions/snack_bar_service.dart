import 'package:flutter/material.dart';

import '../../routes/routes.dart';

class SnackBarService {
  static final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  static void showSnackBar({
    required String content,
    Color? backgroundColor,
  }) {
    final context = RootNavigatorKey.key.currentState!.overlay!.context;
    scaffoldKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.02,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04,
            vertical: MediaQuery.of(context).size.height * 0.01,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          content: Text(
            content,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          backgroundColor:
              backgroundColor ?? Theme.of(context).colorScheme.surface,
          behavior: SnackBarBehavior.floating,
          // Set behavior to floating
        ),
      );
  }
}
