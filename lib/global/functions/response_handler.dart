import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cache/cache.dart';

import '../../routes/routes.dart';
import 'snack_bar_service.dart';

class ResponseHandler {
  static Future<dynamic> handleResponse({
    required http.Response response,
  }) async {
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      await Cache().deleteToken().then((value) {
        SnackBarService.showSnackBar(
          content: 'Unauthorized',
          backgroundColor:
              Theme.of(RootNavigatorKey.key.currentContext!).colorScheme.error,
        );
      });
    } else {
      SnackBarService.showSnackBar(
        content: json.decode(response.body),
        backgroundColor:
            Theme.of(RootNavigatorKey.key.currentContext!).colorScheme.error,
      );
    }
  }
}
