import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoist/todoist.dart';

class DueItem extends StatelessWidget {
  const DueItem({super.key, required this.due});

  final Due due;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.calendar_today_rounded,
          size: 15.sp,
          color: DateTime.now().isAfter(DateTime.parse(due.date))
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).hintColor,
        ),
        10.horizontalSpace,
        Text(
          '${due.string}, ${due.date.toString()}',
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: DateTime.now().isAfter(DateTime.parse(due.date))
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).hintColor,
              ),
        ),
      ],
    );
  }
}
