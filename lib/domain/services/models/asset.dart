import 'package:freezed_annotation/freezed_annotation.dart';

part 'asset.freezed.dart';

@freezed
abstract class Asset with _$Asset {
  const factory Asset({String uri, int width, int height}) = _Asset;
}
