import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../history.dart';
import 'history_view.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  static Route route() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const HistoryPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
      fullscreenDialog: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryBloc(),
      child: const HistoryView(),
    );
  }
}
