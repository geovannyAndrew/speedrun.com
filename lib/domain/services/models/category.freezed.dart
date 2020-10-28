// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Category _$CategoryFromJson(Map<String, dynamic> json) {
  return _Category.fromJson(json);
}

/// @nodoc
class _$CategoryTearOff {
  const _$CategoryTearOff();

// ignore: unused_element
  _Category call({String id, String name, String weblink, String rules}) {
    return _Category(
      id: id,
      name: name,
      weblink: weblink,
      rules: rules,
    );
  }

// ignore: unused_element
  Category fromJson(Map<String, Object> json) {
    return Category.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Category = _$CategoryTearOff();

/// @nodoc
mixin _$Category {
  String get id;
  String get name;
  String get weblink;
  String get rules;

  Map<String, dynamic> toJson();
  $CategoryCopyWith<Category> get copyWith;
}

/// @nodoc
abstract class $CategoryCopyWith<$Res> {
  factory $CategoryCopyWith(Category value, $Res Function(Category) then) =
      _$CategoryCopyWithImpl<$Res>;
  $Res call({String id, String name, String weblink, String rules});
}

/// @nodoc
class _$CategoryCopyWithImpl<$Res> implements $CategoryCopyWith<$Res> {
  _$CategoryCopyWithImpl(this._value, this._then);

  final Category _value;
  // ignore: unused_field
  final $Res Function(Category) _then;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object weblink = freezed,
    Object rules = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      weblink: weblink == freezed ? _value.weblink : weblink as String,
      rules: rules == freezed ? _value.rules : rules as String,
    ));
  }
}

/// @nodoc
abstract class _$CategoryCopyWith<$Res> implements $CategoryCopyWith<$Res> {
  factory _$CategoryCopyWith(_Category value, $Res Function(_Category) then) =
      __$CategoryCopyWithImpl<$Res>;
  @override
  $Res call({String id, String name, String weblink, String rules});
}

/// @nodoc
class __$CategoryCopyWithImpl<$Res> extends _$CategoryCopyWithImpl<$Res>
    implements _$CategoryCopyWith<$Res> {
  __$CategoryCopyWithImpl(_Category _value, $Res Function(_Category) _then)
      : super(_value, (v) => _then(v as _Category));

  @override
  _Category get _value => super._value as _Category;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object weblink = freezed,
    Object rules = freezed,
  }) {
    return _then(_Category(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      weblink: weblink == freezed ? _value.weblink : weblink as String,
      rules: rules == freezed ? _value.rules : rules as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Category implements _Category {
  const _$_Category({this.id, this.name, this.weblink, this.rules});

  factory _$_Category.fromJson(Map<String, dynamic> json) =>
      _$_$_CategoryFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String weblink;
  @override
  final String rules;

  @override
  String toString() {
    return 'Category(id: $id, name: $name, weblink: $weblink, rules: $rules)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Category &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.weblink, weblink) ||
                const DeepCollectionEquality()
                    .equals(other.weblink, weblink)) &&
            (identical(other.rules, rules) ||
                const DeepCollectionEquality().equals(other.rules, rules)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(weblink) ^
      const DeepCollectionEquality().hash(rules);

  @override
  _$CategoryCopyWith<_Category> get copyWith =>
      __$CategoryCopyWithImpl<_Category>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CategoryToJson(this);
  }
}

abstract class _Category implements Category {
  const factory _Category(
      {String id, String name, String weblink, String rules}) = _$_Category;

  factory _Category.fromJson(Map<String, dynamic> json) = _$_Category.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get weblink;
  @override
  String get rules;
  @override
  _$CategoryCopyWith<_Category> get copyWith;
}
