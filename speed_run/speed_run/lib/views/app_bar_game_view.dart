import 'package:flutter/material.dart';
import 'package:speed_run/logic/game.dart';

class AppBarGameView extends StatelessWidget{

  final Game game;
  final idTag;

  AppBarGameView({Key key,this.game,this.idTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SliverAppBar(
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        collapseMode: CollapseMode.parallax,
        title: Text(game?.name ?? "",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            )
        ),
        background: Stack(
          children: <Widget>[
            Image.network(
              game?.background?.uri ?? "",
              filterQuality: FilterQuality.low,
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.black54,
              padding: EdgeInsets.only(top:50.0),
              alignment: Alignment(0, 0),
              child: this.game == null ?
              CircularProgressIndicator() :
              Column(
                children: <Widget>[
                  Hero(
                    tag:idTag,
                    child: Image.network(
                      game?.coverMedium?.uri ?? "",
                      height: 120,
                    ),
                  ),
                  Text(
                    game?.platformsAvaible ?? "",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    game?.released ?? "",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}