import 'package:freezed_annotation/freezed_annotation.dart';

part 'asset.freezed.dart';
part 'asset.g.dart';

@freezed
abstract class Asset implements _$Asset {
  const Asset._();

  factory Asset({@required String uri, int width, int height}) = _Asset;

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);

  bool get isYoutube {
    var regex = RegExp(r"^(https?\:\/\/)?(www\.youtube\.com|youtu\.?be)\/.+$");
    return regex.hasMatch(this.uri);
  }

  String get youtubeId {
    var regExp = RegExp(
        r"^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*");
    String you = "";
    Iterable<Match> matches = regExp.allMatches(uri);
    for (Match match in matches) {
      print("${match.group(1)}\n");
      print("${match.group(2)}\n");
      print("${match.group(3)}\n");
      print("${match.group(4)}\n");
    }
    return you;
  }

  bool get isTwitch {
    return this.uri.contains("twitch");
  }
}
