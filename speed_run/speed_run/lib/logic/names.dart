
class Names{
  final String international;
  final String japanese;
  final String twitch;

  Names(
      this.international,
      this.japanese,
      this.twitch
      );

  factory Names.fromJson(Map<String, dynamic> json){
    return Names(
      json["international"].toString(),
      json["japanese"].toString(),
      json["twitch"].toString()
    );
  }
}