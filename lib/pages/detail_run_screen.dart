import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:speed_run/config/app_config.dart';
import 'package:speed_run/internal/keys.dart';
import 'package:speed_run/logic/game.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/logic/user.dart';
import 'package:speed_run/network/rest_api.dart';
import 'package:speed_run/pages/detail_game_screen.dart';
import 'package:speed_run/pages/detail_user_screen.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'package:speed_run/utils/dialogs.dart';
import 'package:speed_run/widgets/app_bar_game_view.dart';
import 'package:url_launcher/url_launcher.dart';

class RunDetailScreen extends StatefulWidget {
  final Run run;
  final bool linkToUser;

  RunDetailScreen({Key key, this.run, this.linkToUser = false})
      : super(key: key);

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
  Run _run;

  @override
  void initState() {
    super.initState();
    _run = widget.run;
    _getRun();
  }

  void _playVideo() {
    FlutterYoutube.playYoutubeVideoByUrl(
      apiKey: API_KEY_YOUTUBE,
      videoUrl: "https://www.youtube.com/watch?v=fhWaJi1Hsfo",
    );
  }

  Future _getRun() {
    var future = RestAPI.instance.getRun(
        id: widget.run.id,
        onSuccess: (run) {
          if (mounted) {
            setState(() {
              this._run = run;
            });
          }
        },
        onError: (error) {
          print(error);
          Dialogs.showResponseErrroAlertDialog(
              buildContext: context,
              error: error,
              onActionAlert: () {
                Navigator.of(context).pop();
              });
        });
    return future;
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
              AppBarGameView(
                game: _run?.game,
                idTag: _run?.idTag,
                onPressGame: () {
                  _goToGameDetail(_run?.game);
                },
              )
            ];
          },
          body: Container(
            color: colors.blackBackground,
            child: SingleChildScrollView(
              child: Container(
                  // Center is a layout widget. It takes a single child and positions it
                  // in the middle of the parent.
                  child: Column(children: <Widget>[
                _buildCardInformation(
                    title: "User",
                    content: FlatButton(
                      padding: EdgeInsets.all(0.0),
                      onPressed: () {
                        if (widget.linkToUser) {
                          _goToUserDetal(_run?.player);
                        }
                      },
                      child: Row(
                        children: <Widget>[
                          _run?.player == null
                              ? CircularProgressIndicator()
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(40.0),
                                  child: FadeInImage.assetNetwork(
                                      image: _run?.player?.urlIcon ??
                                          AppConfig.placeholderImageUrl,
                                      placeholder:
                                          AppConfig.placeholderImageAsset,
                                      width: 50.0,
                                      height: 50.0,
                                      fit: BoxFit.cover),
                                ),
                          Expanded(
                              child: Container(
                            margin: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        _run?.player?.name ?? "",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0),
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
                                        fontWeight: FontWeight.normal,
                                        fontSize: 13.0),
                                  ),
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                    )),
                _buildCardInformation(
                    title: "Category",
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _run?.category?.name ?? "",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                        Text(
                          _run?.category?.rules ?? "",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    )),
                _buildCardInformation(
                    title: "Time",
                    content: Text(
                      _run?.times?.primaryString ?? "",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    )),
                _run?.youtubeUrl != null
                    ? _buildVideoCard(
                        title: "Youtube",
                        url: _run?.youtubeUrl,
                        asset: "assets/images/youtube_logo_dark.jpg")
                    : Container(),
                _run?.twitchUrl != null
                    ? _buildVideoCard(
                        title: "Twitch",
                        url: _run?.twitchUrl,
                        asset: "assets/images/twitch_logo.jpg")
                    : Container()
              ])),
            ),
          )),
      // This trailing comma makes auto-formatting nicer for build methods.)
    );
  }

  Card _buildCardInformation({String title, Widget content}) {
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

  Card _buildVideoCard({String title, String url, String asset}) {
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
                  child: Image.asset(asset, fit: BoxFit.cover),
                ),
              ),
              Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 80.0,
              )
            ],
          ),
          onTap: () {
            _launchURL(url);
          },
        ));
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _goToUserDetal(User user) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => UserDetailScreen(user: user)));
  }

  void _goToGameDetail(Game game) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => GameDetailScreen(game: game)));
  }
}
