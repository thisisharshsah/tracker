import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'global/global.dart';
import 'routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc()..add(const InitialTheme()),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return ScreenUtilInit(
            child: MaterialApp(
              locale: const Locale('en', 'US'),
              darkTheme: state.themeData,
              navigatorObservers: [RouteObserver<PageRoute>()],
              title: 'Tracker',
              scaffoldMessengerKey: SnackBarService.scaffoldKey,
              theme: state.themeData,
              debugShowCheckedModeBanner: false,
              initialRoute: Routes.splash,
              navigatorKey: RootNavigatorKey.key,
              onGenerateRoute: RouteGenerator.generateRoute,
            ),
          );
        },
      ),
    );
  }
}
