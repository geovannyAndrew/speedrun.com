import 'package:flutter/material.dart';
import 'package:speed_run/screens/games_navigation_screen.dart';
import 'package:speed_run/screens/runs_navigation_screen.dart';
import 'package:speed_run/screens/users_navigation_screen.dart';
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

  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  Icon _searchIcon;
  Widget _appBarTitle;
  final GlobalObjectKey<RunsNavigationScreenState> _runScreenKey = GlobalObjectKey<RunsNavigationScreenState>(titles[0]);
  final GlobalObjectKey<GamesNavigationScreenState> _gameScreenKey = GlobalObjectKey<GamesNavigationScreenState>(titles[1]);

  static final titles = ["Runs","Games","Users"];
  int _selectedIndex = 0;
  var _widgetOptions;

  void _onMenuSelected(int index){
    setState(() {
      _selectedIndex = index;
      _configureAppBarTitle();
    });
  }

  @override
  void initState() {
    _widgetOptions = [
      RunsNavigationScreen(key: _runScreenKey),
      GamesNavigationScreen(key: _gameScreenKey),
      UsersNavigationScreen(),
    ];
    _configureAppBarTitle();
    super.initState();
  }

  void _configureAppBarTitle(){
    this._searchIcon = new Icon(Icons.search);
    this._appBarTitle = Text(titles[_selectedIndex],
      style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold
      ),
    );
    _filter.clear();
  }

  void _configureAppBarSearch(){
    this._searchIcon = new Icon(Icons.close);
    this._appBarTitle = new TextField(
      autofocus: true,
      controller: _filter,
      cursorColor: Colors.white,
      style: TextStyle(
          color: Colors.white,
          fontSize: 16.0
      ),
      decoration: new InputDecoration(
          prefixIcon: new Icon(Icons.search,color: Colors.white,),
          hintText: 'Search...',
          hintStyle: TextStyle(
              color: Colors.white70
          )
      ),
      textInputAction: TextInputAction.search,
      onSubmitted: (query){
        setState(() {
          _searchText = query;
          if(_selectedIndex == 1){
            _gameScreenKey.currentState.onQuerySearch(_searchText);
          }

        });
      },
    );
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
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: _appBarTitle,
        centerTitle: true,
        actions: <Widget>[
          _selectedIndex != 0 ?
          IconButton(
            icon: _searchIcon,
            onPressed: (){
              setState(() {
                if (this._searchIcon.icon == Icons.search) {
                  _configureAppBarSearch();
                } else {
                  _configureAppBarTitle();
                }
              });
            },
          ) : Divider()
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: _widgetOptions[_selectedIndex]
      ),
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
              textTheme: Theme
                  .of(context)
                  .textTheme
                  .copyWith(caption: new TextStyle(color: Colors.white))),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.directions_run), title: Text('Runs')),
            BottomNavigationBarItem(icon: Icon(Icons.games), title: Text('Games')),
            BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle), title: Text('Users'))
            ],
            currentIndex: _selectedIndex,
            onTap: _onMenuSelected,
          )
      )// This trailing comma makes auto-formatting nicer for build methods.)
    );
  }

}
