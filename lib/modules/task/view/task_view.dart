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
        title: Text(
          project.order == 0 ? 'Inbox' : project.name,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        leading: project.order == 0
            ? const SizedBox()
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
        actions: [
          CustomIconButton(
            label: 'Add',
            icon: Icons.add_rounded,
            onPressed: () => showCustomBottomSheet(
              child: BlocProvider(
                create: (context) =>
                    TaskBloc(todoist: Todoist(), project: project),
                child: TaskAddUpdateView(
                  task: Task.empty,
                  action: TaskAction.add,
                ),
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<TaskBloc>().add(const TaskInitial());
        },
        child: BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CustomLoading());
          } else if (state.tasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.list_alt_rounded,
                    size: 100.sp,
                    weight: 1,
                    color: Theme.of(context).hintColor,
                  ),
                  10.verticalSpace,
                  Text(
                    'Please add a task',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).hintColor,
                        ),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: state.tasks.length,
            itemBuilder: (context, index) {
              final task = state.tasks[index];
              return TaskCard(
                task: task,
                onCheckBoxChanged: (value) {
                  context.read<TaskBloc>().add(TaskClosed(task));
                },
                onPressed: () {
                  showCustomBottomSheet(
                    child: BlocProvider(
                      create: (context) => TaskBloc(
                        todoist: Todoist(),
                        project: project,
                      )..add(FetchDuration(task)),
                      child: TaskAddUpdateView(
                        task: task,
                        action: TaskAction.view,
                      ),
                    ),
                  );
                },
              );
            },
          );
        }),
      ),
    );
  }
}

class TaskAddUpdateView extends StatelessWidget {
  const TaskAddUpdateView({
    super.key,
    required this.task,
    required this.action,
  });

  final Task task;
  final TaskAction action;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            width: 1.sw,
            padding: action == state.action
                ? EdgeInsets.only(left: 10.sp)
                : EdgeInsets.symmetric(horizontal: 10.sp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                action == state.action
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: EdgeInsets.only(bottom: 10.sp),
                        child: Text(
                          action == TaskAction.add ? 'Add Task' : 'Update Task',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                action == state.action
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            task.content,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          10.horizontalSpace,
                          CustomIconButton(
                            label: 'Edit',
                            onPressed: () =>
                                context.read<TaskBloc>().add(TaskEdit(task)),
                            icon: Icons.edit_rounded,
                          ),
                        ],
                      )
                    : CustomTextFormField(
                        initialValue: state.content,
                        label: 'Content',
                        hint: 'Enter task content',
                        icon: Icons.content_paste,
                        onChanged: (value) => context
                            .read<TaskBloc>()
                            .add(TaskContentChanged(value!)),
                      ),
                10.verticalSpace,
                action == state.action
                    ? SizedBox(
                        width: 0.8.sw,
                        child: Text(
                          task.description,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      )
                    : CustomTextFormField(
                        initialValue: state.description,
                        label: 'Description',
                        hint: 'Enter task description',
                        icon: Icons.description,
                        maxLines: 3,
                        onChanged: (value) => context
                            .read<TaskBloc>()
                            .add(TaskDescriptionChanged(value!)),
                      ),
                10.verticalSpace,
                action == state.action
                    ? task.due != Due.empty
                        ? DueItem(due: task.due!)
                        : const SizedBox.shrink()
                    : CustomTextFormField(
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
                          await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                            builder: (context, child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  primaryColor: Theme.of(context).primaryColor,
                                ),
                                child: child!,
                              );
                            },
                          ).then((value) {
                            if (value != null) {
                              context
                                  .read<TaskBloc>()
                                  .add(TaskDueDateChanged(value));
                            }
                          });
                        },
                        onChanged: (value) {},
                      ),
                10.verticalSpace,
                Wrap(
                  spacing: 10.sp,
                  children: [
                    PriorityItem(
                      priority: 1,
                      isSelected: action == state.action
                          ? task.priority == 1
                          : state.priority == 1,
                      onPressed: () => action == state.action
                          ? null
                          : context
                              .read<TaskBloc>()
                              .add(const TaskPriorityChanged(1)),
                    ),
                    PriorityItem(
                      priority: 2,
                      isSelected: action == state.action
                          ? task.priority == 2
                          : state.priority == 2,
                      onPressed: () => action == state.action
                          ? null
                          : context
                              .read<TaskBloc>()
                              .add(const TaskPriorityChanged(2)),
                    ),
                    PriorityItem(
                      priority: 3,
                      isSelected: action == state.action
                          ? task.priority == 3
                          : state.priority == 3,
                      onPressed: () => action == state.action
                          ? null
                          : context
                              .read<TaskBloc>()
                              .add(const TaskPriorityChanged(3)),
                    ),
                    PriorityItem(
                      priority: 4,
                      isSelected: action == state.action
                          ? task.priority == 4
                          : state.priority == 4,
                      onPressed: () => action == state.action
                          ? null
                          : context
                              .read<TaskBloc>()
                              .add(const TaskPriorityChanged(4)),
                    ),
                  ],
                ),
                20.verticalSpace,
                action == state.action
                    ? TaskTimeSpend(task: task)
                    : PrimaryButton(
                        label: action == TaskAction.add
                            ? 'Add Task'
                            : 'Update Task',
                        onPressed: () {
                          context.read<TaskBloc>().add(
                                action == TaskAction.add
                                    ? const TaskCreated()
                                    : TaskUpdated(task),
                              );
                          Navigator.of(context).pop();
                          context.read<TaskBloc>().add(const TaskInitial());
                        },
                      ),
                30.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
  }
}

class TaskTimeSpend extends StatelessWidget {
  const TaskTimeSpend({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              state.duration.toString().toDuration(),
              style: Theme.of(context).textTheme.labelMedium,
            ),
            GestureDetector(
              onTap: () {
                context.read<TaskBloc>().add(
                      state.isTaskRunning
                          ? TaskPaused(task)
                          : TaskResumed(task),
                    );
              },
              child: Padding(
                padding: EdgeInsets.only(right: 10.sp),
                child: CircleAvatar(
                  radius: 15.sp,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(
                    state.isTaskRunning
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

extension IntToDuration on String {
  String toDuration() {
    final duration = Duration(seconds: int.parse(this));
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }
}
