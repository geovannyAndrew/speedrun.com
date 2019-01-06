
import 'package:flutter/material.dart';
import 'package:speed_run/logic/game.dart';
import 'package:speed_run/utils/colors.dart' as colors;

class GameItemView extends StatelessWidget{

  final Game _game;
  final bool _showLoading;
  final Function(Game game) _onTap;

  GameItemView(this._game,this._showLoading, this._onTap);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridTile(
        child: InkResponse(
          child: Card(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0,horizontal: 4.0),
              child: Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 0.77,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: Image.network(
                          _game?.coverLarge?.uri ?? "",
                          fit:BoxFit.cover),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment:Alignment(0.0, -1.0),
                      margin: EdgeInsets.only(top: 4.0),
                      child: Text(
                        _game.name,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2.0),
                    child: Center(
                      child: Text(
                        _game.released,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.0,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            color: colors.blackCard,
          ),
          onTap: (){
            _onTap(_game);
          },
        ),

        //_showLoading ? CircularProgressIndicator() : Container()

    );
  }

}