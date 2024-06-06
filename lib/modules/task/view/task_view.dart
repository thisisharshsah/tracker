import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoist/todoist.dart';
import 'package:intl/intl.dart';

import '../../../global/global.dart';
import '../task.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks', style: Theme.of(context).textTheme.labelLarge),
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => showCustomBottomSheet(
              child: BlocProvider(
                create: (context) => TaskBloc(Todoist()),
                child: BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.sp),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Add Task',
                                style: Theme.of(context).textTheme.labelLarge),
                            20.verticalSpace,
                            CustomTextFormField(
                              label: 'Content',
                              hint: 'Enter task content',
                              icon: Icons.content_paste,
                              onChanged: (value) => context
                                  .read<TaskBloc>()
                                  .add(TaskContentChanged(value!)),
                            ),
                            10.verticalSpace,
                            CustomTextFormField(
                              label: 'Description',
                              hint: 'Enter task description',
                              icon: Icons.description,
                              maxLines: 3,
                              onChanged: (value) => context
                                  .read<TaskBloc>()
                                  .add(TaskDescriptionChanged(value!)),
                            ),
                            10.verticalSpace,
                            CustomTextFormField(
                              label: 'Due Date',
                              controller: TextEditingController()
                                ..text = state.dueDate == ''
                                    ? ''
                                    : DateFormat('yyyy-MM-dd').format(
                                        DateTime.parse(state.dueDate),
                                      ),
                              hint: 'Enter task due date',
                              icon: Icons.calendar_today,
                              onTap: () async {
                                final DateTime? selectedDate =
                                    await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                  builder: (context, child) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                        primaryColor:
                                            Theme.of(context).primaryColor,
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                                if (selectedDate != null) {
                                  context.read<TaskBloc>().add(
                                        TaskDueDateChanged(
                                          selectedDate,
                                        ),
                                      );
                                }
                              },
                              onChanged: (value) {},
                            ),
                            10.verticalSpace,
                            Wrap(
                              spacing: 10.sp,
                              children: [
                                PriorityItem(
                                  priority: 1,
                                  isSelected: state.priority == 1,
                                  onPressed: () => context
                                      .read<TaskBloc>()
                                      .add(const TaskPriorityChanged(1)),
                                ),
                                PriorityItem(
                                  priority: 2,
                                  isSelected: state.priority == 2,
                                  onPressed: () => context
                                      .read<TaskBloc>()
                                      .add(const TaskPriorityChanged(2)),
                                ),
                                PriorityItem(
                                  priority: 3,
                                  isSelected: state.priority == 3,
                                  onPressed: () => context
                                      .read<TaskBloc>()
                                      .add(const TaskPriorityChanged(3)),
                                ),
                                PriorityItem(
                                  priority: 4,
                                  isSelected: state.priority == 4,
                                  onPressed: () => context
                                      .read<TaskBloc>()
                                      .add(const TaskPriorityChanged(4)),
                                ),
                              ],
                            ),
                            20.verticalSpace,
                            PrimaryButton(
                              label: 'Add Task',
                              onPressed: () {
                                context.read<TaskBloc>().add(
                                      TaskCreated(
                                        content: state.content,
                                        description: state.description,
                                        due: DateTime.parse(state.dueDate),
                                        priority: state.priority,
                                        projectId: project.id,
                                      ),
                                    );
                                Navigator.of(context).pop();
                              },
                            ),
                            20.verticalSpace,
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
        return ListView.builder(
          itemCount: state.tasks.length,
          itemBuilder: (context, index) {
            final task = state.tasks[index];
            return ListTile(
              tileColor: task.isCompleted
                  ? Theme.of(context).cardColor
                  : Theme.of(context).colorScheme.primary.withOpacity(0.1),
              leading: Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                value: task.isCompleted,
                onChanged: (value) {},
              ),
              title: Text(task.content),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (task.description != '') Text(task.description),
                  if (task.due != Due.empty)
                    Text('${task.due!.string}, ${task.due!.date.toString()}'),
                ],
              ),
              onTap: () {},
            );
          },
        );
      }),
    );
  }
}

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
      color: isSelected
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).hintColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
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
