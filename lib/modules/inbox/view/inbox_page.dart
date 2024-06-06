import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../inbox.dart';
import 'inbox_view.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  static Route route() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const InboxPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
      fullscreenDialog: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InboxBloc(),
      child: const InboxView(),
    );
  }
}
