import 'package:flutter/material.dart';
import 'package:speed_run/config/app_config.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/utils/colors.dart' as colors;
class UserRunItemView extends StatelessWidget{

   final Run _run;
   final bool _showLoading;
   final Function(Run run) _onTap;

   UserRunItemView(this._run,this._showLoading, this._onTap);


   @override
   Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        FlatButton(
          padding: EdgeInsets.all(0.0),
          child: Card(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: FadeInImage.assetNetwork(
                          image: _run.game?.coverMedium?.uri ?? AppConfig.placeholderImageUrl,
                          placeholder: AppConfig.placeholderImageAsset,
                          width: 80.0,
                          height: 80.0,
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
                                    child: Text(_run?.game?.names?.international,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      _run?.category?.name,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.0
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 2.0),
                                child: Row(
                                    children: <Widget>[
                                      Text(
                                        _run?.times?.primaryString,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.bold
                                        ),
                                      )
                                    ]
                                ),
                              )
                            ],
                          ),
                        )
                    )
                  ],
                )
            ),
            color: colors.blackCard,
          ),
          onPressed: (){
              _onTap(_run);
              return null;
          },
        ),
        _showLoading ? CircularProgressIndicator() : Container()
      ],
    );
  }


}