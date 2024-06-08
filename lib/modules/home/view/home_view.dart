import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoist/todoist.dart';

import '../../../global/global.dart';
import '../home.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const WishUser(),
              10.verticalSpace,
              const HorizontalProgressItem(),
            ],
          ),
        ),
      ),
    );
  }
}

class HorizontalProgressItem extends StatelessWidget {
  const HorizontalProgressItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 300.sp,
      ),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
        children: <Widget>[
          const ProgressItem(
            title: 'To Do',
          ),
          5.horizontalSpace,
          const ProgressItem(
            title: 'In Progress',
          ),
          5.horizontalSpace,
          const ProgressItem(
            title: 'Completed',
          ),
        ],
      ),
    );
  }
}

class ProgressItem extends StatelessWidget {
  final String title;

  const ProgressItem({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<Task>(
      builder: (context, candidateData, rejectedData) {
        return _buildProgressItem(context);
      },
      onWillAccept: (data) {
        return true;
      },
      onAccept: (data) {
        print('$title accepted');
      },
    );
  }

  Widget _buildProgressItem(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 150.sp,
            maxWidth: 250.sp,
          ),
          child: Card(
            color: Theme.of(context).primaryColor,
            elevation: 0,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.sp),
              side: BorderSide(
                color: Theme.of(context).hintColor,
                width: 1.sp,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 50.sp,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10.sp),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.sp),
                        topRight: Radius.circular(8.sp),
                      ),
                    ),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 250.sp,
                    maxWidth: 250.sp,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: title == 'To Do'
                        ? state.tasks.where((element) {
                            return element.duration == TaskDuration.empty;
                          }).length
                        : title == 'In Progress'
                            ? state.tasks.where((element) {
                                return element.duration != TaskDuration.empty;
                              }).length
                            : title == 'Completed'
                                ? state.tasks.where((element) {
                                    return element.isCompleted;
                                  }).length
                                : 0,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return ProgressTaskCard(
                        task: title == 'To Do'
                            ? state.tasks.where((element) {
                                return element.duration == TaskDuration.empty;
                              }).elementAt(index)
                            : title == 'In Progress'
                                ? state.tasks.where((element) {
                                    return element.duration !=
                                        TaskDuration.empty;
                                  }).elementAt(index)
                                : title == 'Completed'
                                    ? state.tasks.where((element) {
                                        return element.isCompleted;
                                      }).elementAt(index)
                                    : Task.empty,
                        onPressed: () {},
                        onCheckBoxChanged: (value) {},
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class WishUser extends StatelessWidget {
  const WishUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                DateTime.now().hour < 12
                    ? 'Good Morning!'
                    : DateTime.now().hour < 17
                        ? 'Good Afternoon!'
                        : DateTime.now().hour < 20
                            ? 'Good Evening!'
                            : 'Good Night!',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              10.horizontalSpace,
              Icon(
                DateTime.now().hour < 12
                    ? Icons.wb_sunny
                    : DateTime.now().hour < 17
                        ? Icons.brightness_5
                        : DateTime.now().hour < 20
                            ? Icons.brightness_6
                            : Icons.nights_stay,
                color: Theme.of(context).textTheme.labelLarge!.color,
                size: 18.sp,
              ),
            ],
          ),
          Text(
            formatDate(DateTime.now()),
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}

String formatDate(DateTime date) {
  String formattedDate = '';
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  List<String> days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];
  formattedDate =
      '${days[date.weekday - 1]} ${date.day} ${months[date.month - 1]}, ${date.year}';
  return formattedDate;
}
