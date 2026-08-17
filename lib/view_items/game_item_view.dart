import 'package:flutter/material.dart';
import 'package:speed_run/config/app_config.dart';
import 'package:speed_run/logic/game.dart';
import 'package:speed_run/utils/colors.dart' as colors;

class GameItemView extends StatelessWidget {
  final Game _game;
  final bool _showLoading;
  final Function(Game game) _onTap;

  const GameItemView(this._game, this._showLoading, this._onTap);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: InkResponse(
        child: Card(
          color: colors.blackCard,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
            child: Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 0.77,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Hero(
                      tag: _game.id,
                      child: FadeInImage.assetNetwork(
                        image: _game.coverLarge.uri ?? "",
                        placeholder: AppConfig.placeholderImageAsset,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            AppConfig.placeholderImageAsset,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: const Alignment(0.0, -1.0),
                    margin: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      _game.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 2.0),
                  child: Center(
                    child: Text(
                      _game.released,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          _onTap(_game);
        },
      ),
    );
  }
}
