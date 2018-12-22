import 'package:flutter/material.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/utils/colors.dart' as colors;
class RunItemView extends StatelessWidget{

   final Run _run;

   RunItemView(this._run);


   @override
   Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
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
                    "https://www.speedrun.com/themes/battletoads_nes/cover-128.png",
                    width: 80.0,
                    height: 80.0,
                    fit:BoxFit.cover),
              ),
              Expanded(
                child: Container(
                  alignment:Alignment(-1.0, -1.0),
                  margin: const EdgeInsets.only( left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text("Name Game",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Category Run Game Any %",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.0
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:2.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 25.0,
                              height: 25.0,
                              margin: const EdgeInsets.only(right: 4.0),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                      "https://www.speedrun.com/themes/user/qwertylool/image.png",
                                    ),
                                    fit:BoxFit.cover
                                ),
                                borderRadius: new BorderRadius.all(new Radius.circular(12.5)),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Name Player as long",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0
                                ),
                              ),
                            ),
                            Image.network(
                              "https://www.countryflags.io/co/flat/64.png",
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
                            "11h 12m 13s",
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
    );
  }


}