import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:speed_run/config/app_config.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'package:speed_run/views/app_bar_game_view.dart';

class RunDetailScreen extends StatefulWidget {

  RunDetailScreen({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _RunDetailScreenState createState() => _RunDetailScreenState();
}

class _RunDetailScreenState extends State<RunDetailScreen> {



  @override
  void initState() {
    super.initState();

  }

  void _playVideo(){
    FlutterYoutube.playYoutubeVideoByUrl(
        apiKey: AppConfig.apiKeyYoutube,
        videoUrl: "https://www.youtube.com/watch?v=fhWaJi1Hsfo",
    );
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            AppBarGameView()
          ];
        },
        body: Container(
          color: colors.blackBackground,
          child: SingleChildScrollView(
            child: Container(
                // Center is a layout widget. It takes a single child and positions it
                // in the middle of the parent.
              child: Column(
                children: <Widget>[
                  _buildCardInformation(
                    title: "User",
                    content: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40.0),
                          child: Image.network(
                            //_user.urlIcon ?? "",
                              "https://www.speedrun.com/themes/user/cheese/image.png",
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
                                        child: Text(
                                          //_user?.name,
                                          "Nombre",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0
                                          ),
                                        ),
                                      ),
                                      Image.network(
                                        //_user.country?.urlIcon ?? "",
                                        "https://www.countryflags.io/be/flat/64.png",
                                        width: 15.0,
                                        height: 13.0,
                                        fit: BoxFit.fill,
                                      )
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment(-1.0, 0),
                                    child: Text(
                                      //_user?.country?.name ?? "",
                                      "Colombia",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.0
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment(-1.0, 0),
                                    child: Text(
                                      //_user?.region?.name ?? "",
                                      "Region Name",
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
                  _buildCardInformation(
                    title: "Category",
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "All tracks no items",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0
                          ),
                        ),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
                          style: TextStyle(
                              color: Colors.white,

                          ),
                        )
                      ],
                    )
                  ),
                  _buildCardInformation(
                      title: "Time",
                      content: Text(
                        "0h 30m 2s",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0
                        ),
                      )
                  ),
                  _buildVideoCard(
                      title: "Youtube",
                      url: "https://img.youtube.com/vi/aJkicyBZ4kw/hqdefault.jpg",
                      isYoutube: true
                  ),
                  _buildVideoCard(
                      title: "Twitch",
                      url: "https://img.youtube.com/vi/aJkicyBZ4kw/hqdefault.jpg",
                      isYoutube: false
                  )
                ]
              )
            ),
          ),
        )
      ),
      // This trailing comma makes auto-formatting nicer for build methods.)
    );
  }

  Card _buildCardInformation({String title,Widget content}){
    return Card(
      color: colors.blackCard,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
            Divider(
              height: 4.0,
            ),
            content
          ],
        ),
      ),
    );
  }

  Card _buildVideoCard({String title,String url,bool isYoutube}){
    return _buildCardInformation(
      title: title,
      content: GestureDetector(
        child: Stack(
          alignment: Alignment(0.0, 0.0),
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.77,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Image.network(
                    url,
                    fit:BoxFit.cover),
              ),
            ),
            Icon(Icons.play_arrow,
              color: Colors.white,
              size: 80.0,
            )
          ],
        ),
      )
    );
  }

}
