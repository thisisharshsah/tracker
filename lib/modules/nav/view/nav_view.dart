import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../global/global.dart';
import '../nav.dart';

class NavView extends StatelessWidget {
  const NavView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBloc, NavState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          resizeToAvoidBottomInset: true,
          floatingActionButton: FloatingActionButton(
            key: const Key('floating_action_button'),
            onPressed: () {
              showCustomBottomSheet(
                child: Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Create a new project',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                      10.verticalSpace,
                      CustomTextFormField(
                        label: 'Project name',
                        icon: Icons.title,
                        hint: 'Enter project name',
                        onChanged: (value) {
                          context
                              .read<NavBloc>()
                              .add(ProjectNameChanged(name: value!));
                        },
                      ),
                      10.verticalSpace,
                      PrimaryButton(
                        label: 'Create',
                        onPressed: () {
                          context.read<NavBloc>().add(const NavAdd());
                        },
                      ),
                      10.verticalSpace,
                    ],
                  ),
                ),
              );
            },
            backgroundColor: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.sp)),
            ),
            child: Icon(
              Icons.add,
              color: Theme.of(context).cardColor,
            ),
          ),
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
            onTap: (index) {
              context.read<NavBloc>().add(NavUpdate(index));
            },
          ),
        );
      },
    );
  }
}
