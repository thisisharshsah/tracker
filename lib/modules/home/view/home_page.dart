import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoist/todoist.dart';

import '../home.dart';
import 'home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route route() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
      fullscreenDialog: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeBloc(todoist: Todoist())..add(const HomeInitial()),
      child: const HomeView(),
    );
  }
}
