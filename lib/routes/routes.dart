import 'package:flutter/material.dart';
import 'package:todoist/todoist.dart';
import '../modules/history/history.dart';
import '../modules/home/home.dart';
import '../modules/inbox/inbox.dart';
import '../modules/nav/nav.dart';
import '../modules/project/project.dart';
import '../modules/splash/splash.dart';
import '../modules/task/task.dart';
import 'not_found_page.dart';
export 'root_navigator_key.dart';

class Routes {
  static const String splash = '/';
  static const String nav = '/nav';
  static const String home = '/home';
  static const String project = '/project';
  static const String task = '/task';
  static const String inbox = '/inbox';
  static const String history = '/history';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return SplashPage.route();
      case Routes.nav:
        return NavPage.route();
      case Routes.home:
        return HomePage.route();
      case Routes.project:
        return ProjectPage.route();
      case Routes.task:
        return TaskPage.route(project: settings.arguments as Project);
      case Routes.inbox:
        return InboxPage.route();
      case Routes.history:
        return HistoryPage.route();
      default:
        return NotFoundPage.route();
    }
  }
}
