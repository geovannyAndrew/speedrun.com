import 'package:flutter/material.dart';

class AppBarGameView extends StatelessWidget{

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
        title: Text("Mario Kart 64",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            )
        ),
        background: Stack(
          children: <Widget>[
            Image.network(
              "https://www.speedrun.com/themes/mk64/background.png",
              filterQuality: FilterQuality.low,
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.black54,
              padding: EdgeInsets.only(top:50.0),
              alignment: Alignment(0, 0),
              child: Column(
                children: <Widget>[
                  Image.network(
                    "https://www.speedrun.com/themes/mk64/cover-256.png",
                    height: 120,
                  ),
                  Text(
                    "Xbox, PC, PS3 Switch",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  Text(
                    "2019",
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