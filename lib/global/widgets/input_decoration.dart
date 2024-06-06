import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController? controller;
  final void Function(String?)? onChanged;
  final void Function()? onTap;
  final Widget? suffixIcon;
  final bool obscureText;
  final Widget? prefixIcon;
  final int maxLines;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.controller,
    required this.onChanged,
    this.onTap,
    this.suffixIcon,
    this.obscureText = false,
    this.prefixIcon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: label,
      onChanged: onChanged,
      onTap: onTap,
      showCursor: onTap == null,
      controller: controller,
      obscureText: obscureText,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon ??
            Icon(
              icon,
              color: Theme.of(context).hintColor,
            ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Theme.of(context).cardColor,
        contentPadding: EdgeInsets.all(10.sp),
        labelStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).hintColor,
            ),
        hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).hintColor,
            ),
        errorStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.sp),
          borderSide: BorderSide(
            color: Theme.of(context).hintColor,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.sp),
          borderSide: BorderSide(
            color: Theme.of(context).hintColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.sp),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.sp),
          borderSide: BorderSide(
            color: Theme.of(context).hintColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.sp),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.minLength(6),
      ]),
    );
  }
}
