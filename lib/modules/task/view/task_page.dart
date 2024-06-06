import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoist/todoist.dart';

import '../task.dart';
import 'task_view.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key, required this.project});

  final Project project;

  static Route route({required Project project}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          TaskPage(project: project),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
      fullscreenDialog: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(Todoist())..add(TaskInitial(project)),
      child: TaskView(project: project),
    );
  }
}
