import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              // list of row of todo, in progress, done
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
    return Container(
      height: 300.sp,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
        children: <Widget>[
          const ProgressItem(
            title: 'To Do',
            count: 5,
          ),
          5.horizontalSpace,
          const ProgressItem(
            title: 'In Progress',
            count: 3,
          ),
          5.horizontalSpace,
          const ProgressItem(
            title: 'Completed',
            count: 2,
          ),
        ],
      ),
    );
  }
}

class ProgressItem extends StatelessWidget {
  final String title;
  final int count;

  const ProgressItem({
    super.key,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.sp,
      height: 300.sp,
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(10.sp),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor,
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
            10.verticalSpace,
            Expanded(
              flex: 5,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: count,
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 5.sp),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.sp),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.sp),
                        side: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 1.sp,
                        ),
                      ),
                      tileColor: Theme.of(context).hintColor,
                      textColor: Theme.of(context).textTheme.labelMedium!.color,
                      trailing: Icon(
                        Icons.check_circle,
                        color: Theme.of(context).textTheme.labelMedium!.color,
                      ),
                      title: Text(
                        'Task ${index + 1}',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
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
