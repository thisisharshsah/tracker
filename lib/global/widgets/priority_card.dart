import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriorityItem extends StatelessWidget {
  const PriorityItem({
    super.key,
    required this.priority,
    required this.isSelected,
    required this.onPressed,
  });

  final int priority;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected && priority == 1
          ? Colors.red
          : isSelected && priority == 2
              ? Colors.orange
              : isSelected && priority == 3
                  ? Colors.yellow
                  : isSelected && priority == 4
                      ? Colors.green
                      : Theme.of(context).scaffoldBackgroundColor,
      borderRadius: BorderRadius.circular(8.sp),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8.sp),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
          child: Text(
            'Priority $priority',
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: isSelected
                      ? Theme.of(context).colorScheme.onPrimary
                      : priority == 1
                          ? Colors.red
                          : priority == 2
                              ? Colors.orange
                              : priority == 3
                                  ? Colors.yellow
                                  : priority == 4
                                      ? Colors.green
                                      : Colors.grey,
                ),
          ),
        ),
      ),
    );
  }
}
