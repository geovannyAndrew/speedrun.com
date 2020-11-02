import 'package:flutter/material.dart';
import 'package:speed_run/presentation/pages/games_navigation_screen.dart';
import 'package:speed_run/presentation/pages/runs_navigation_screen.dart';
import 'package:speed_run/presentation/pages/users_navigation_screen.dart';
import 'package:speed_run/utils/colors.dart' as colors;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
  List<Widget> _widgetOptions;

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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: _widgetOptions[_selectedIndex]),
        /*floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),*/
        bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
                // sets the background color of the `BottomNavigationBar`
                canvasColor: colors.blackDark,
                // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                primaryColor: colors.greenAccent,
                textTheme: Theme.of(context)
                    .textTheme
                    .copyWith(caption: new TextStyle(color: Colors.white))),
            child: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.directions_run), title: Text('Runs')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.games), title: Text('Games')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.supervised_user_circle),
                    title: Text('Users'))
              ],
              currentIndex: _selectedIndex,
              onTap: _onMenuSelected,
            )) // This trailing comma makes auto-formatting nicer for build methods.)
        );
  }
}
