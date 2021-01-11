import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:speed_run/config/app_config.dart';
import 'package:speed_run/data/models/game.dart';
import 'package:speed_run/data/models/run.dart';
import 'package:speed_run/data/models/user.dart';
import 'package:speed_run/internal/keys.dart';
import 'package:speed_run/network/rest_api.dart';
import 'package:speed_run/presentation/pages/detail_game_screen.dart';
import 'package:speed_run/presentation/pages/detail_user_screen.dart';
import 'package:speed_run/presentation/runs/run_details/cubit/run_details_cubit.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'package:speed_run/utils/dialogs.dart';
import 'package:speed_run/presentation/widgets/app_bar_game_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../injection.dart';

class RunDetailScreen extends StatelessWidget {
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

  void _playVideo() {
    FlutterYoutube.playYoutubeVideoByUrl(
      apiKey: API_KEY_YOUTUBE,
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
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) {
            getIt<RunDetailsCubit>().loadRun(run);
            return getIt<RunDetailsCubit>();
          })
        ],
        child: BlocConsumer<RunDetailsCubit, RunDetailsState>(
            listener: (context, state) {
          print("listener");
        }, listenWhen: (previous, now) {
          print("listenWhen");
        }, builder: (context, state) {
          return Scaffold(
            body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    AppBarGameView(
                      game: state.run?.game,
                      idTag: state.run?.idTag,
                      onPressGame: () {
                        _goToGameDetail(context, state.run?.game);
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
                              if (linkToUser) {
                                _goToUserDetal(context, state.run?.player);
                              }
                            },
                            child: Row(
                              children: <Widget>[
                                state.run?.player == null
                                    ? CircularProgressIndicator()
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        child: FadeInImage.assetNetwork(
                                            image: state.run?.player?.urlIcon ??
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
                                              state.run?.player?.name ?? "",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0),
                                            ),
                                          ),
                                          Image.network(
                                            state.run?.player?.country
                                                    ?.urlIcon ??
                                                "",
                                            width: 15.0,
                                            height: 13.0,
                                            fit: BoxFit.fill,
                                          )
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment(-1.0, 0),
                                        child: Text(
                                          state.run?.player
                                                  ?.countryRegionName ??
                                              "",
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
                                state.run?.category?.name ?? "",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                              Text(
                                state.run?.category?.rules ?? "",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )),
                      _buildCardInformation(
                          title: "Time",
                          content: Text(
                            state.run?.times?.primaryString ?? "",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          )),
                      state.run?.youtubeUrl != null
                          ? _buildVideoCard(
                              title: "Youtube",
                              url: state.run?.youtubeUrl,
                              asset: "assets/images/youtube_logo_dark.jpg")
                          : Container(),
                      state.run?.twitchUrl != null
                          ? _buildVideoCard(
                              title: "Twitch",
                              url: state.run?.twitchUrl,
                              asset: "assets/images/twitch_logo.jpg")
                          : Container()
                    ])),
                  ),
                )),
            // This trailing comma makes auto-formatting nicer for build methods.)
          );
        }));
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

  void _goToUserDetal(BuildContext context, User user) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => UserDetailScreen(user: user)));
  }

  void _goToGameDetail(BuildContext context, Game game) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => GameDetailScreen(game: game)));
  }
}
