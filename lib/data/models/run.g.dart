// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'run.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Run _$_$_RunFromJson(Map<String, dynamic> json) {
  return _$_Run(
    id: json['id'] as String,
    date: json['date'] as String,
    comment: json['comment'] as String,
    submitted: json['submitted'] as String,
    times: json['times'] == null
        ? null
        : Times.fromJson(json['times'] as Map<String, dynamic>),
    category:
        Run._getCategoryFromJsonData(json['category'] as Map<String, dynamic>),
    game: Run._getGameFromJsonData(json['game'] as Map<String, dynamic>),
    players:
        Run._getPlayersFromJsonData(json['players'] as Map<String, dynamic>),
    videos: Run._getAssetsFromJsonData(json['videos'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_RunToJson(_$_Run instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'comment': instance.comment,
      'submitted': instance.submitted,
      'times': instance.times,
      'category': instance.category,
      'game': instance.game,
      'players': instance.players,
      'videos': instance.videos,
    };
