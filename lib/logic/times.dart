
class Times{

  final String primary;
  final double primarySeconds;
  final String realtime;
  final double realtimeSeconds;

  Times(
      this.primary,
      this.primarySeconds,
      this.realtime,
      this.realtimeSeconds
      );

  factory Times.fromJson(Map<String, dynamic> json){
    return Times(json['primary']!= null ? json['primary'].toString(): null,
        json['primary_t'].toDouble(),
        json["realtime"].toString(),
        json["realtime_t"].toDouble()
    );
  }

  String get primaryString{
    var milliseconds = (primarySeconds * 1000).toInt();
    var duration = Duration(milliseconds: milliseconds);
    return "${duration.inHours}h ${duration.inMinutes%60}m ${duration.inSeconds%60}s";
  }
}