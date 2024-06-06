import 'dart:async';

import 'package:flutter/material.dart';

import '../../routes/routes.dart';
import '../functions/functions.dart';

class CustomLoading extends StatefulWidget {
  const CustomLoading({super.key, this.label, this.onTimeout});

  final String? label;
  final Function? onTimeout;

  @override
  State<CustomLoading> createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      SnackBarService.showSnackBar(
        content: 'Request timed out, please try again.',
        backgroundColor: Theme.of(context).colorScheme.error,
      );
      if (widget.onTimeout != null) {
        widget.onTimeout!();
      } else {
        Navigator.of(RootNavigatorKey.context).pop();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.label == null
              ? Container()
              : Text(
                  widget.label!,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
          widget.label == null
              ? Container()
              : Padding(padding: EdgeInsets.only(top: height * 0.05)),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.primary,
            ),
            strokeWidth: 2,
          ),
        ],
      ),
    );
  }
}
