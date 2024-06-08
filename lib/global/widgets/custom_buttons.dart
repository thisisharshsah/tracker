import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  final bool isFilled;
  final bool isDisabled;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isFilled = true,
    this.isDisabled = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return MaterialButton(
      key: key,
      onPressed: onPressed,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(vertical: height * 0.02),
      minWidth: double.infinity,
      color: isFilled
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).scaffoldBackgroundColor,
      disabledColor: isDisabled
          ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
          : Theme.of(context).colorScheme.primary,
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: isFilled
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = Colors.transparent,
  });

  final String label;
  final void Function() onPressed;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.sp,
          vertical: 5.sp,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor,
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).primaryColor,
              ),
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
  });

  final void Function() onPressed;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.sp),
            bottomLeft: Radius.circular(18.sp),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(5.sp),
          child: Row(
            children: [
              CircleAvatar(
                radius: 10.sp,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                child: Icon(
                  icon,
                  size: 15.sp,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              10.horizontalSpace,
              Padding(
                padding: EdgeInsets.only(right: 8.sp),
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
