import 'package:flutter/material.dart';
import 'package:speed_run/config/app_config.dart';
import 'package:speed_run/logic/user.dart';
import 'package:speed_run/utils/colors.dart' as colors;

class UserItemView extends StatelessWidget {
  final User _user;
  final bool _showLoading;
  final Function(User user) _onTap;

  const UserItemView(this._user, this._showLoading, this._onTap);

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
                children: <Widget>[
                  SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40.0),
                      child: Hero(
                        tag: _user.id,
                        child: FadeInImage.assetNetwork(
                          placeholder: AppConfig.placeholderImageAsset,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              AppConfig.placeholderImageAsset,
                            );
                          },
                          image: _user.urlIcon ?? "",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  _user.name,
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
                                  _user.country?.urlIcon ?? "",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            alignment: const Alignment(-1.0, 0),
                            child: Text(
                              _user.countryRegionName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                              ),
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
          onPressed: () {
            _onTap(_user);
          },
        ),
        if (_showLoading) const CircularProgressIndicator() else Container(),
      ],
    );
  }
}
