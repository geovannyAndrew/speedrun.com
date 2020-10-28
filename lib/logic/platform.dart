class Platform {
  final String id;
  final String name;
  final String released;

  Platform(this.id, this.name, this.released);

  factory Platform.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      return Platform(json["id"].toString(), json["name"].toString(),
          json["released"].toString());
    } else {
      return null;
    }
  }
}
