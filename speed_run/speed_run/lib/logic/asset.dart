

class Asset{

  final String uri;
  final int width;
  final int height;

  Asset(
      this.uri,
      this.width,
      this.height
  );

  bool get isYoutube{
    var regex = RegExp(r"^(https?\:\/\/)?(www\.youtube\.com|youtu\.?be)\/.+$");
    return regex.hasMatch(this.uri);
  }

  String get youtubeId{
    var regExp = RegExp(r"^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*");
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

  bool get isTwitch{
    return this.uri.contains("twitch");
  }

  factory Asset.fromJson(Map<String, dynamic> json){
    return Asset(json['uri']?.toString() ?? "",
        json['width']!= null ? json['width'].toInt() : 0,
        json["height"]!=null ? json["height"].toInt() : 0
    );
  }
}