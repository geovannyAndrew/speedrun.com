import 'package:flutter/material.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/utils/colors.dart' as colors;
class RunItemView extends StatelessWidget{

   final Run _run;
   final bool _showLoading;

   RunItemView(this._run,this._showLoading);


   @override
   Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Card(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Image.network(
                        _run.game?.coverLarge?.uri ?? "",
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
                                            _run?.player?.urlIcon ?? "",
                                          ),
                                          fit:BoxFit.cover
                                      ),
                                      borderRadius: new BorderRadius.all(new Radius.circular(12.5)),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      _run?.player?.names?.international ?? "",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0
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
        _showLoading ? CircularProgressIndicator() : Container()
      ],
    );
  }


}