import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../routes/routes.dart';

void showCustomBottomSheet({required Widget child}) {
  showModalBottomSheet(
    context: RootNavigatorKey.key.currentContext!,
    backgroundColor: Theme.of(RootNavigatorKey.key.currentContext!).cardColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8.sp),
        topRight: Radius.circular(8.sp),
      ),
    ),
    useSafeArea: true,
    isScrollControlled: true,
    enableDrag: true,
    showDragHandle: true,
    useRootNavigator: true,
    elevation: 10.sp,
    constraints: BoxConstraints(maxHeight: 600.sp),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: child,
      );
    },
  );
}