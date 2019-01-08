

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
    var regex = RegExp(r"/^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=|\?v=)([^#\&\?]*).*/");
    return regex.hasMatch(this.uri);
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