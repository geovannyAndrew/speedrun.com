class Times {
  final String? primary;
  final double primarySeconds;
  final String realtime;
  final double realtimeSeconds;

  Times(this.primary, this.primarySeconds, this.realtime, this.realtimeSeconds);

  factory Times.fromJson(Map<String, dynamic> json) {
    return Times(
      json['primary']?.toString(),
      double.parse(json['primary_t'].toString()),
      json["realtime"].toString(),
      double.parse(json["realtime_t"].toString()),
    );
  }

  String get primaryString {
    final milliseconds = (primarySeconds * 1000).toInt();
    final duration = Duration(milliseconds: milliseconds);
    return "${duration.inHours}h ${duration.inMinutes % 60}m ${duration.inSeconds % 60}s";
  }
}
