

class Asset{
  final String uri;
  final int width;
  final int height;

  Asset(
      this.uri,
      this.width,
      this.height
      );

  factory Asset.fromJson(Map<String, dynamic> json){
    return Asset(json['uri']?.toString() ?? "",
        json['width'].toInt(),
        json["height"].toInt()
    );
  }
}