part of 'nav_bloc.dart';

class NavState extends Equatable {
  const NavState({
    this.selectedIndex = 0,
    this.projectName = '',
    this.pages = const <Widget>[
      HomePage(),
      ProjectPage(),
      InboxPage(),
      HistoryPage(),
    ],
    this.items = const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home_rounded),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.fact_check_rounded),
        label: 'Projects',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.mail_rounded),
        label: 'Inbox',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.history_rounded),
        label: 'History',
      ),
    ],
  });

  final int selectedIndex;
  final List<Widget> pages;
  final List<BottomNavigationBarItem> items;
  final String projectName;

  NavState copyWith({
    int? selectedIndex,
    List<Widget>? pages,
    List<BottomNavigationBarItem>? items,
    String? projectName,
  }) {
    return NavState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      pages: pages ?? this.pages,
      items: items ?? this.items,
      projectName: projectName ?? this.projectName,
    );
  }

  @override
  List<Object> get props => [selectedIndex, pages, items, projectName];

  @override
  bool get stringify => true;
}
