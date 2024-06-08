import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoist/todoist.dart';

import 'custom_checkbox.dart';
import 'due_item.dart';
import 'priority_icon.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.onPressed,
    required this.onCheckBoxChanged,
    this.color,
  });

  final Task task;
  final void Function() onPressed;
  final void Function(bool?) onCheckBoxChanged;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: color ?? Theme.of(context).cardColor,
      leading: CustomCheckBox(
        value: task.isCompleted,
        color: task.priority == 1
            ? Colors.red
            : task.priority == 2
                ? Colors.orange
                : task.priority == 3
                    ? Colors.yellow
                    : task.priority == 4
                        ? Colors.green
                        : Theme.of(context).hintColor,
        onChanged: (value) {
          onCheckBoxChanged(value);
        },
      ),
      title: SizedBox(
        width: 0.8.sw,
        child: Text(
          task.content,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
      horizontalTitleGap: 10.sp,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (task.description != '')
            Container(
              width: 0.8.sw,
              padding: EdgeInsets.only(top: 5.sp),
              child: Text(
                task.description,
                style: Theme.of(context).textTheme.labelSmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          task.due! == Due.empty ? const SizedBox() : 10.verticalSpace,
          task.due == Due.empty ? const SizedBox() : DueItem(due: task.due!)
        ],
      ),
      // trailing: PriorityIcon(priority: task.priority),
      onTap: onPressed,
    );
  }
}

class ProgressTaskCard extends StatelessWidget {
  const ProgressTaskCard({
    super.key,
    required this.task,
    required this.onPressed,
    required this.onCheckBoxChanged,
    this.color,
  });

  final Task task;
  final void Function() onPressed;
  final void Function(bool?) onCheckBoxChanged;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<Task>(
      onDragCompleted: () {
        print('Drag completed');
      },
      data: task,
      feedback: Material(
        child: buildTaskCard(context),
      ),
      childWhenDragging: const SizedBox(),
      child: buildTaskCard(context),
    );
  }

  Widget buildTaskCard(BuildContext context) {
    return SizedBox(
      width: 250.sp,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10.sp),
        tileColor: color ?? Theme.of(context).cardColor,
        leading: CustomCheckBox(
          value: task.isCompleted,
          onChanged: (value) {
            onCheckBoxChanged(value);
          },
          color: task.priority == 1
              ? Colors.red
              : task.priority == 2
                  ? Colors.orange
                  : task.priority == 3
                      ? Colors.yellow
                      : task.priority == 4
                          ? Colors.green
                          : Theme.of(context).hintColor,
        ),
        title: SizedBox(
          width: 100.sp,
          child: Text(
            task.content,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        horizontalTitleGap: 10.sp,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (task.description != '')
              Container(
                width: 0.8.sw,
                padding: EdgeInsets.only(top: 5.sp),
                child: Text(
                  task.description,
                  style: Theme.of(context).textTheme.labelSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            task.due! == Due.empty ? const SizedBox() : 10.verticalSpace,
            task.due == Due.empty ? const SizedBox() : DueItem(due: task.due!)
          ],
        ),
        // trailing: PriorityIcon(priority: task.priority),
        onTap: onPressed,
      ),
    );
  }
}
