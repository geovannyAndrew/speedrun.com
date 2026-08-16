import 'dart:async';

import 'package:flutter/services.dart';

class FlutterYoutube {
  static const MethodChannel _channel =
      const MethodChannel('PonnamKarthik/flutter_youtube');

  static const EventChannel _stream =
      const EventChannel('PonnamKarthik/flutter_youtube_stream');

  static String? getIdFromUrl(String url, [bool trimWhitespaces = true]) {
    if (url.isEmpty) return null;
    // ignore: parameter_assignments
    if (trimWhitespaces) url = url.trim();

    for (var exp in _regexps) {
      RegExpMatch? match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) return match.group(1);
    }

    return null;
  }

  static List<RegExp> _regexps = [
    RegExp(
        r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
    RegExp(
        r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
    RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
  ];

  static playYoutubeVideoByUrl(
      {required String apiKey,
      required String videoUrl,
      bool autoPlay = false,
      bool fullScreen = false}) {
    if (apiKey.isEmpty) {
      throw "Invalid API Key";
    }

    if (videoUrl.isEmpty) {
      throw "Invalid Youtube URL";
    }

    String? id = getIdFromUrl(videoUrl);

    if (id == null) {
      throw "Error extracting Youtube id from URL";
    }

    final Map<String, dynamic> params = <String, dynamic>{
      'api': apiKey,
      'id': id,
      'autoPlay': autoPlay,
      'fullScreen': fullScreen
    };
    _channel.invokeMethod('playYoutubeVideo', params);
  }

  static playYoutubeVideoById(
      {required String apiKey,
      required String videoId,
      bool autoPlay = false,
      bool fullScreen = false}) {
    if (apiKey.isEmpty) {
      throw "Invalid API Key";
    }

    if (videoId.isEmpty) {
      throw "Invalid Youtube URL";
    }

    final Map<String, dynamic> params = <String, dynamic>{
      'api': apiKey,
      'id': videoId,
      'autoPlay': autoPlay,
      'fullScreen': fullScreen
    };
    _channel.invokeMethod('playYoutubeVideo', params);
  }

  Stream<String>? done;

  Stream<String> get onVideoEnded {
    var d = _stream.receiveBroadcastStream().map<String>((element) => element);
    return d;
  }
}
