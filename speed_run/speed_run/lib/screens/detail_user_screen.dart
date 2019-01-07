import 'package:flutter/material.dart';
import 'package:speed_run/logic/category.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/network/rest_api.dart';
import 'package:speed_run/screens/detail_run_screen.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'package:speed_run/view_items/game_category_run_item_view.dart';
import 'package:speed_run/views/app_bar_game_view.dart';
import 'package:speed_run/utils/after_layout.dart';

class UserDetailScreen extends StatefulWidget {

  var _user;
  final idUser;
  var _runs = List<Run>();
  //var tabs = List<Tab>();

  UserDetailScreen({Key key, this.idUser}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen>{

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
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
      backgroundColor: colors.blackBackground,
      body:widget._user == null ?
        Container(
          color: colors.blackBackground,
          alignment: Alignment(0.0, 0.0),
          child: CircularProgressIndicator(),
        ) :
        NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              AppBarGameView(
                //game: widget._game
              ),
            ];
          },
          body: Container(
            color: colors.blackBackground,

          ),
        )
    );
  }
}
