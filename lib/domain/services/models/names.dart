import 'package:freezed_annotation/freezed_annotation.dart';
part 'names.freezed.dart';

@freezed
abstract class Names with _$Names {
  const factory Names({String international, String japanese, String twitch}) =
      _Names;
}
