import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:speed_run/data/models/asset.dart';
import 'package:speed_run/data/models/category.dart';
import 'package:speed_run/data/models/game.dart';
import 'package:speed_run/data/models/times.dart';
import 'package:speed_run/data/models/user.dart';
import 'package:timeago/timeago.dart' as timeago;

part 'run.freezed.dart';
part 'run.g.dart';

@freezed
abstract class Run implements _$Run {
  const Run._();

  @JsonSerializable(createToJson: true)
  const factory Run(
      {String id,
      String date,
      String comment,
      String submitted,
      Times times,
      @JsonKey(name: "category", fromJson: Run._getCategoryFromJsonData)
          Category category,
      @JsonKey(name: "game", fromJson: Run._getGameFromJsonData)
          Game game,
      @JsonKey(name: "players", fromJson: Run._getPlayersFromJsonData)
          List<User> players,
      @JsonKey(name: "videos", fromJson: Run._getAssetsFromJsonData)
          List<Asset> videos}) = _Run;

  factory Run.fromJson(Map<String, dynamic> json) => _$RunFromJson(json);

  static Category _getCategoryFromJsonData(Map<String, dynamic> json) =>
      Category.fromJson(json["data"] as Map<String, dynamic>);

  static Game _getGameFromJsonData(Map<String, dynamic> json) =>
      Game.fromJson(json["data"] as Map<String, dynamic>);

  static List<User> _getPlayersFromJsonData(Map<String, dynamic> json) =>
      (json["data"] as List)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList();

  static List<Asset> _getAssetsFromJsonData(Map<String, dynamic> json) {
    return (json["links"] as List)
        .map((e) => Asset.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  User get player {
    if ((players?.length ?? 0) > 0) {
      return players[0];
    } else {
      return null;
    }
  }

  String get youtubeUrl {
    var video =
        videos?.firstWhere((asset) => asset.isYoutube, orElse: () => null);
    //var idYoutube = video.youtubeId;
    //print(idYoutube);
    return video?.uri;
  }

  String get twitchUrl {
    return videos
        ?.firstWhere((asset) => asset.isTwitch, orElse: () => null)
        ?.uri;
  }

  String get idTag {
    return "$id-${game.id}";
  }

  String get submittedAgo {
    if (submitted != null) {
      final datetime = DateTime.parse(submitted);
      return timeago.format(datetime).toString();
    } else {
      return "";
    }
  }
}
