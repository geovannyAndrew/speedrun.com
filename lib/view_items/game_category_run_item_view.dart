import 'package:flutter/material.dart';
import 'package:speed_run/config/app_config.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/utils/colors.dart' as colors;
class GameCategoryRunItemView extends StatelessWidget{

   final Run _run;
   final bool _showLoading;
   final Function(Run run) _onTap;

   GameCategoryRunItemView(this._run,this._showLoading, this._onTap);


   @override
   Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        GestureDetector(
          child: Card(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40.0),
                      child: FadeInImage.assetNetwork(
                          image:_run?.player?.urlIcon ?? AppConfig.placeholderImageUrl,
                          placeholder: AppConfig.placeholderImageAsset,
                          width: 50.0,
                          height: 50.0,
                          fit:BoxFit.cover),
                    ),
                    Expanded(
                        child: Container(
                          margin: const EdgeInsets.only( left: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(_run?.player?.name ?? "",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0
                                      ),
                                    ),
                                  ),
                                  Image.network(
                                    _run?.player?.country?.urlIcon ?? "",
                                    width: 15.0,
                                    height: 13.0,
                                    fit: BoxFit.fill,
                                  )
                                ],
                              ),
                              Container(
                                alignment: Alignment(-1.0, 0),
                                child: Text(
                                  _run?.player?.countryRegionName ?? "",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment(-1.0, 0),
                                child: Text(
                                  _run?.submittedAgo,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment(-1.0, 0),
                                child: Text(
                                  _run?.times?.primaryString ?? "",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                    )
                  ],
                )
            ),
            color: colors.blackCard,
          ),
          onTap: (){
              _onTap(_run);
              return null;
          },
        ),
        _showLoading ? CircularProgressIndicator() : Container()
      ],
    );
  }


}