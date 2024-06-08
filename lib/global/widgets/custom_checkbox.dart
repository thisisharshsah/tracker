import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    super.key,
    required this.value,
    required this.onChanged,
    this.color,
  });

  final bool value;
  final void Function(bool?) onChanged;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      checkColor: Theme.of(context).colorScheme.primary,
      activeColor: Theme.of(context).cardColor,
      visualDensity: VisualDensity.compact,
      side: BorderSide(
        color: value
            ? Theme.of(context).cardColor
            : color ?? Theme.of(context).hintColor,
        width: 1.sp,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.sp),
      ),
      onChanged: onChanged,
    );
  }
}
