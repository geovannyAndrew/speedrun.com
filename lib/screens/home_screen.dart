import 'package:flutter/material.dart';
import 'package:speed_run/screens/games_navigation_screen.dart';
import 'package:speed_run/screens/runs_navigation_screen.dart';
import 'package:speed_run/screens/users_navigation_screen.dart';
import 'package:speed_run/utils/colors.dart' as colors;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalObjectKey<RunsNavigationScreenState> _runScreenKey =
      GlobalObjectKey<RunsNavigationScreenState>(titles[0]);
  final GlobalObjectKey<GamesNavigationScreenState> _gameScreenKey =
      GlobalObjectKey<GamesNavigationScreenState>(titles[1]);
  final GlobalObjectKey<UsersNavigationScreenState> _userScreenKey =
      GlobalObjectKey<UsersNavigationScreenState>(titles[2]);

  static final titles = ["Runs", "Games", "Users"];
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions;

  void _onMenuSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _widgetOptions = [
      RunsNavigationScreen(key: _runScreenKey),
      GamesNavigationScreen(key: _gameScreenKey),
      UsersNavigationScreen(key: _userScreenKey),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: _widgetOptions[_selectedIndex],),
        bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
                canvasColor: colors.blackDark,
                primaryColor: colors.greenAccent,
                textTheme: Theme.of(context)
                    .textTheme
                    .copyWith(bodyMedium: const TextStyle(color: Colors.white)),),
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.directions_run), label: 'Runs',),
                BottomNavigationBarItem(
                    icon: Icon(Icons.games), label: 'Games',),
                BottomNavigationBarItem(
                    icon: Icon(Icons.supervised_user_circle),
                    label: 'Users',),
              ],
              currentIndex: _selectedIndex,
              onTap: _onMenuSelected,
            ),),
        );
  }
}
