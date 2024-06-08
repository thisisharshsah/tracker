import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../nav.dart';

class NavView extends StatelessWidget {
  const NavView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBloc, NavState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: IndexedStack(
            index: state.selectedIndex,
            children: state.pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            key: const Key('bottom_nav_bar'),
            items: state.items,
            enableFeedback: false,
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            selectedItemColor:
                Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            unselectedItemColor:
                Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
            elevation: Theme.of(context).bottomNavigationBarTheme.elevation,
            type: Theme.of(context).bottomNavigationBarTheme.type,
            currentIndex: state.selectedIndex,
            onTap: (index) => context.read<NavBloc>().add(NavUpdate(index)),
          ),
        );
      },
    );
  }
}
