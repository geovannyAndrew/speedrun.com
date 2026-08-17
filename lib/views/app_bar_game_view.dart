import 'package:flutter/material.dart';
import 'package:speed_run/logic/game.dart';

class AppBarGameView extends StatelessWidget {
  final Game? game;
  final String? idTag;
  final Function? onPressGame;

  const AppBarGameView({Key? key, this.game, this.idTag, this.onPressGame})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 260.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 160),
          child: Text(game?.name ?? "",
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  textBaseline: TextBaseline.alphabetic,),),
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
              padding: const EdgeInsets.only(top: 50.0),
              alignment: const Alignment(0, 0),
              child: game == null
                  ? const CircularProgressIndicator()
                  : Column(
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            if (onPressGame != null) {
                              onPressGame!();
                            }
                          },
                          child: Hero(
                            tag: idTag ?? "",
                            child: Image.network(
                              game?.coverMedium.uri ?? "",
                              height: 120,
                            ),
                          ),
                        ),
                        Text(
                          game?.platformsAvaible ?? "",
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          game?.released ?? "",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
