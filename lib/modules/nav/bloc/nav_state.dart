part of 'nav_bloc.dart';

class NavState extends Equatable {
  const NavState({
    this.selectedIndex = 0,
    this.pages = const <Widget>[
      HomePage(),
      ProjectPage(),
      InboxPage(),
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
    ],
  });

  final int selectedIndex;
  final List<Widget> pages;
  final List<BottomNavigationBarItem> items;

  NavState copyWith({
    int? selectedIndex,
    List<Widget>? pages,
    List<BottomNavigationBarItem>? items,
  }) {
    return NavState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      pages: pages ?? this.pages,
      items: items ?? this.items,
    );
  }

  @override
  List<Object> get props => [selectedIndex, pages, items];

  @override
  bool get stringify => true;
}
