import 'package:flutter/material.dart';
import 'package:speed_run/config/app_config.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/utils/colors.dart' as colors;
class UserRunItemView extends StatelessWidget{

   final Run _run;
   final bool _showLoading;
   final Function(Run run) _onTap;

   const UserRunItemView(this._run,this._showLoading, this._onTap);


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
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: FadeInImage.assetNetwork(
                          image: _run.game.coverMedium.uri ?? AppConfig.placeholderImageUrl,
                          placeholder: AppConfig.placeholderImageAsset,
                          width: 80.0,
                          height: 80.0,
                          fit:BoxFit.cover,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              AppConfig.placeholderImageAsset,
                              width: 80.0,
                              height: 80.0,
                              fit: BoxFit.cover,
                            );
                          },),
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
                                  Text(
                                    _run.category.name ?? "",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    _run.submittedAgo,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.0,
                                    ),
                                  ),
                                ],
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
