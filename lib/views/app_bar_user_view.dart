import 'package:flutter/material.dart';
import 'package:speed_run/config/app_config.dart';
import 'package:speed_run/logic/asset.dart';
import 'package:speed_run/logic/game.dart';
import 'package:speed_run/logic/user.dart';
import 'package:url_launcher/url_launcher.dart';

class AppBarUserView extends StatelessWidget{

  final User user;
  final String idUser;

  AppBarUserView({Key key,this.user,this.idUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SliverAppBar(
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        collapseMode: CollapseMode.parallax,
        title: Text(user?.name ?? "",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            )
        ),
        background: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: user?.gradientStyle ?? LinearGradient(
                  colors: [Colors.black,Colors.black]
                )
              ),
              padding: EdgeInsets.only(top:50.0),
              alignment: Alignment(0, 0),
              child: Column(
                children: <Widget>[
                  ClipOval(
                    child: Hero(
                      tag:idUser,
                      child: FadeInImage.assetNetwork(
                        image:user?.urlIcon ?? AppConfig.placeholderImageUrl,
                        placeholder: AppConfig.placeholderImageAsset,
                        height: 90,
                        width: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Text(
                      user?.countryRegionName ?? "",
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0
                      ),
                    ),
                  ),
                  user?.country?.urlIcon == null ?
                      Container():
                      Image.network(
                        user?.country?.urlIcon,
                        width: 20.0,
                        height: 15.0,
                        fit: BoxFit.fill,
                      ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      user?.assetTwitter != null ? _buildSocialButton(user.assetTwitter,"assets/images/twitter.png") : Container(),
                      user?.assetYoutube != null ? _buildSocialButton(user.assetYoutube,"assets/images/youtube.png") : Container(),
                      user?.assetTwitch != null ? _buildSocialButton(user.assetTwitch,"assets/images/twitch.png") : Container(),
                    ],
                  )
                ],
              ),
            ),
            this.user == null ? Center(child: CircularProgressIndicator()) : Container()
          ],
        ),
      ),
    );
  }

  Container _buildSocialButton(Asset asset, String imageAsset){
    return Container(
      child: IconButton(
          onPressed: (){
            _launchURL(asset.uri);
          },
          icon: Image.asset(
            imageAsset,
            width: 40.0,
            height: 40.0,
            fit: BoxFit.fill,
          )
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}