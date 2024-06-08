import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriorityIcon extends StatelessWidget {
  const PriorityIcon({super.key, required this.priority});

  final int priority;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.flag_circle_rounded,
      size: 20.sp,
      color: priority == 1
          ? Colors.red
          : priority == 2
              ? Colors.orange
              : priority == 3
                  ? Colors.yellow
                  : priority == 4
                      ? Colors.green
                      : Colors.grey,
    );
  }
}
