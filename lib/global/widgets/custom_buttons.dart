import 'package:flutter/material.dart';

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
          horizontal: MediaQuery.of(context).size.width * 0.15,
          vertical: MediaQuery.of(context).size.height * 0.01,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor,
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }
}
