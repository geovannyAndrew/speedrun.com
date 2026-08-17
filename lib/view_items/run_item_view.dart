import 'package:flutter/material.dart';
import 'package:speed_run/config/app_config.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/utils/colors.dart' as colors;
class RunItemView extends StatelessWidget{

   final Run _run;
   final bool _showLoading;
   final Function(Run run) _onTap;

   const RunItemView(this._run,this._showLoading, this._onTap);


   @override
   Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(0.0),
          ),
          child: Card(
            color: colors.blackCard,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 80.0,
                      height: 80.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4.0),
                        child: Hero(
                          tag: _run.idTag,
                          child: FadeInImage.assetNetwork(
                              image:_run.game.coverMedium.uri ?? "",
                              placeholder: AppConfig.placeholderImageAsset,
                              fit:BoxFit.cover,
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  AppConfig.placeholderImageAsset,
                                  fit: BoxFit.cover,
                                );
                              },),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                          margin: const EdgeInsets.only( left: 8.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(_run.game.names.international ?? "",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      _run.category.name ?? "",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:2.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 20.0,
                                      height: 20.0,
                                      margin: const EdgeInsets.only(right: 4.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              _run.player?.urlIcon ?? AppConfig.placeholderImageUrl,
                                            ),
                                            fit:BoxFit.cover,
                                        ),
                                        borderRadius: const BorderRadius.all(Radius.circular(12.5)),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        _run.player?.names.international ?? "",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                      height: 13.0,
                                      child: Image.network(
                                        _run.player?.country?.urlIcon ?? "",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Row(
                                    children: <Widget>[
                                      Text(
                                        _run.times?.primaryString ?? "",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    ),
                  ],
                ),
            ),
          ),
          onPressed: (){
              _onTap(_run);
              return;
          },
        ),
        if (_showLoading) const CircularProgressIndicator() else Container(),
      ],
    );
  }


}
