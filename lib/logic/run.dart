import 'package:speed_run/logic/asset.dart';
import 'package:speed_run/logic/category.dart';
import 'package:speed_run/logic/game.dart';
import 'package:speed_run/logic/times.dart';
import 'package:speed_run/logic/user.dart';
import 'package:timeago/timeago.dart' as timeago;

class Run {
  final String id;
  final String? date;
  final String? comment;
  final String? submitted;
  final Times? times;
  final Category category;
  final Game game;
  final List<User> players;
  final List<Asset>? videos;

  Run(this.id, this.date, this.comment, this.submitted, this.times,
      this.category, this.game, this.players, this.videos);

  User? get player {
    if (players.isNotEmpty) {
      return players[0];
    } else {
      return null;
    }
  }

  String? get youtubeUrl {
    var video = videos?.firstWhere((asset) => asset.isYoutube,
        orElse: () => Asset("", 0, 0));
    return video?.uri;
  }

  String? get twitchUrl {
    return videos
        ?.firstWhere((asset) => asset.isTwitch,
            orElse: () => Asset("", 0, 0))
        ?.uri;
  }

  String get idTag {
    return "$id-${game.id}";
  }

  String get submittedAgo {
    if (submitted != null) {
      var datetime = DateTime.parse(submitted!);
      return timeago.format(datetime);
    } else {
      return "";
    }
  }

  factory Run.fromJson(Map<String, dynamic> json) {
    return Run(
        json['id'] as String,
        json['date'] as String?,
        json["comment"] as String?,
        json["submitted"] as String?,
        json["times"] != null
            ? Times.fromJson(json["times"] as Map<String, dynamic>)
            : null,
        Category.fromJson(json["category"]["data"] as Map<String, dynamic>),
        Game.fromJson(json["game"]["data"] as Map<String, dynamic>),
        json["players"] is List
            ? []
            : (json["players"]["data"] as List)
                .map((model) => User.fromJson(model as Map<String, dynamic>))
                .toList(),
        json["videos"] != null && json["videos"]["links"] is List
            ? (json["videos"]["links"] as List)
                .map((model) => Asset.fromJson(model as Map<String, dynamic>))
                .toList()
            : null);
  }
}
