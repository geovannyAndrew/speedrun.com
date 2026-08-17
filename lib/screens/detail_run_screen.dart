import 'package:flutter/material.dart';
import 'package:speed_run/config/app_config.dart';
import 'package:speed_run/logic/game.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/logic/user.dart';
import 'package:speed_run/network/rest_api.dart';
import 'package:speed_run/screens/detail_game_screen.dart';
import 'package:speed_run/screens/detail_user_screen.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'package:speed_run/utils/dialogs.dart';
import 'package:speed_run/views/app_bar_game_view.dart';
import 'package:url_launcher/url_launcher.dart';

class RunDetailScreen extends StatefulWidget {
  final Run? run;
  final bool linkToUser;

  const RunDetailScreen({Key? key, this.run, this.linkToUser = false})
      : super(key: key);

  @override
  _RunDetailScreenState createState() => _RunDetailScreenState();
}

class _RunDetailScreenState extends State<RunDetailScreen> {
  Run? _run;

  @override
  void initState() {
    super.initState();
    _run = widget.run;
    _getRun();
  }

  Future _getRun() {
    var future = RestAPI.instance.getRun(
        id: widget.run!.id,
        onSuccess: (run) {
          if (mounted) {
            setState(() {
              _run = run;
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
                  child: Column(children: <Widget>[
                _buildCardInformation(
                    title: "User",
                    content: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(0.0),
                      ),
                      onPressed: () {
                        if (widget.linkToUser) {
                          _goToUserDetal(_run?.player);
                        }
                      },
                      child: Row(
                        children: <Widget>[
                          if (_run?.player == null)
                            CircularProgressIndicator()
                          else
                            ClipRRect(
                              borderRadius: BorderRadius.circular(40.0),
                              child: FadeInImage.assetNetwork(
                                image: _run?.player?.urlIcon ??
                                    AppConfig.placeholderImageUrl,
                                placeholder: AppConfig.placeholderImageAsset,
                                width: 50.0,
                                height: 50.0,
                                fit: BoxFit.cover,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset(
                                    AppConfig.placeholderImageAsset,
                                    width: 50.0,
                                    height: 50.0,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
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
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                      height: 13.0,
                                      child: Image.network(
                                        _run?.player?.country?.urlIcon ?? "",
                                        fit: BoxFit.fill,
                                      ),
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
    );
  }

  Card _buildCardInformation({required String title, required Widget content}) {
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

  Card _buildVideoCard(
      {required String title, String? url, required String asset}) {
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
            if (url != null) {
              _launchURL(url);
            }
          },
        ));
  }

  _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  void _goToUserDetal(User? user) {
    if (user != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserDetailScreen(user: user)));
    }
  }

  void _goToGameDetail(Game? game) {
    if (game != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GameDetailScreen(game: game)));
    }
  }
}
