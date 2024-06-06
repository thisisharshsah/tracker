import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoist/todoist.dart';

import '../project.dart';
import 'project_view.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({super.key});

  static Route route() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const ProjectPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
      fullscreenDialog: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectBloc(Todoist())..add(const ProjectInitial()),
      child: const ProjectView(),
    );
  }
}
