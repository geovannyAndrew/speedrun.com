import 'package:json_annotation/json_annotation.dart';
import 'package:speed_run/logic/asset.dart';
import 'package:speed_run/logic/category.dart';
import 'package:speed_run/logic/game.dart';
import 'package:speed_run/logic/times.dart';
import 'package:speed_run/logic/user.dart';
import 'package:timeago/timeago.dart' as timeago;
/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.

class Run{

  final String id;
  final String date;
  final String comment;
  final String submitted;
  final Times times;
  final Category category;
  final Game game;
  final List<User> players;
  final List<Asset> videos;

  Run(this.id,
      this.date,
      this.comment,
      this.submitted,
      this.times,
      this.category,
      this.game,
      this.players,
      this.videos);

  User get player{
    if((this.players?.length ?? 0) > 0){
      return this.players[0];
    }
    else{
      return null;
    }
  }
  
  String get youtubeUrl{
    var video = this.videos?.firstWhere((asset)=>asset.isYoutube,orElse:()=> null);
    //var idYoutube = video.youtubeId;
    //print(idYoutube);
    return video?.uri;
  }

  String get twitchUrl{
    return this.videos?.firstWhere((asset)=>asset.isTwitch,orElse:()=> null)?.uri;
  }

  String get idTag{
    return "${id}-${game.id}";
  }

  String get submittedAgo{
    if(submitted!=null){
      var datetime = DateTime.parse(submitted);
      return timeago.format(datetime);
    }
    else{
      return "";
    }
  }


  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson` constructor.
  /// The constructor is named after the source class, in this case User.
  factory Run.fromJson(Map<String, dynamic> json){
    return Run(json['id'] as String,
        json['date'] as String,
        json["comment"] as String,
        json["submitted"] as String,
        json["times"]!=null ? Times.fromJson(json["times"]) : null,
        Category.fromJson(json["category"]["data"]),
        Game.fromJson(json["game"]["data"]),
        json["players"] is List ? null : (json["players"]["data"] as List).map((model)=> User.fromJson(model)).toList(),
        json["videos"]!=null && json["videos"]["links"] is List ? (json["videos"]["links"] as List).map((model)=> Asset.fromJson(model)).toList() : null
    );
  }

}