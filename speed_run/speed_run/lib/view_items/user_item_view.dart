import 'package:flutter/material.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/logic/user.dart';
import 'package:speed_run/utils/colors.dart' as colors;
class UserItemView extends StatelessWidget{

   final User _user;
   final bool _showLoading;

   UserItemView(this._user,this._showLoading);


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
                    child: Image.network(
                        _user.urlIcon ?? "",
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
                                  child: Text(_user?.name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0
                                    ),
                                  ),
                                ),
                                Image.network(
                                  _user.country?.urlIcon ?? "",
                                  width: 15.0,
                                  height: 13.0,
                                  fit: BoxFit.fill,
                                )
                              ],
                            ),
                            Container(
                              alignment: Alignment(-1.0, 0),
                              child: Text(
                                _user?.country?.name ?? "",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.0
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment(-1.0, 0),
                              child: Text(
                                _user?.region?.name ?? "",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.0
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
        ),
        _showLoading ? CircularProgressIndicator() : Container()
      ],
    );
  }


}