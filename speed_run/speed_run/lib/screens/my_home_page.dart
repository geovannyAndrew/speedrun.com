
import 'package:flutter/material.dart';
import 'package:speed_run/screens/runs_navigation_screen.dart';
import 'package:speed_run/utils/colors.dart' as colors;

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final titles = ["Runs","Games","Users"];
  int _selectedIndex = 0;
  final _widgetOptions = [
    RunsNavigationScreen(),
    Text('Index 1: Games'),
    Text('Index 2: Users'),
  ];

  void _onMenuSelected(int index){
    setState(() {
      _selectedIndex = index;
    });
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
        title: Text(titles[_selectedIndex],
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
                Icons.search
            ),
            onPressed: (){

            },
          )
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
      bottomNavigationBar: new Theme(
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