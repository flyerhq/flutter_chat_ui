// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'link_preview.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LinkPreview {

/// The original URL link.
 String get link;/// A description extracted from the link source.
 String? get description;/// The URL of an image associated with the link.
 String? get imageUrl;/// The title extracted from the link source.
 String? get title;
/// Create a copy of LinkPreview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LinkPreviewCopyWith<LinkPreview> get copyWith => _$LinkPreviewCopyWithImpl<LinkPreview>(this as LinkPreview, _$identity);

  /// Serializes this LinkPreview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LinkPreview&&(identical(other.link, link) || other.link == link)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,link,description,imageUrl,title);

@override
String toString() {
  return 'LinkPreview(link: $link, description: $description, imageUrl: $imageUrl, title: $title)';
}


}

/// @nodoc
abstract mixin class $LinkPreviewCopyWith<$Res>  {
  factory $LinkPreviewCopyWith(LinkPreview value, $Res Function(LinkPreview) _then) = _$LinkPreviewCopyWithImpl;
@useResult
$Res call({
 String link, String? description, String? imageUrl, String? title
});




}
/// @nodoc
class _$LinkPreviewCopyWithImpl<$Res>
    implements $LinkPreviewCopyWith<$Res> {
  _$LinkPreviewCopyWithImpl(this._self, this._then);

  final LinkPreview _self;
  final $Res Function(LinkPreview) _then;

/// Create a copy of LinkPreview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? link = null,Object? description = freezed,Object? imageUrl = freezed,Object? title = freezed,}) {
  return _then(_self.copyWith(
link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _LinkPreview extends LinkPreview {
  const _LinkPreview({required this.link, this.description, this.imageUrl, this.title}): super._();
  factory _LinkPreview.fromJson(Map<String, dynamic> json) => _$LinkPreviewFromJson(json);

/// The original URL link.
@override final  String link;
/// A description extracted from the link source.
@override final  String? description;
/// The URL of an image associated with the link.
@override final  String? imageUrl;
/// The title extracted from the link source.
@override final  String? title;

/// Create a copy of LinkPreview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LinkPreviewCopyWith<_LinkPreview> get copyWith => __$LinkPreviewCopyWithImpl<_LinkPreview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LinkPreviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LinkPreview&&(identical(other.link, link) || other.link == link)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,link,description,imageUrl,title);

@override
String toString() {
  return 'LinkPreview(link: $link, description: $description, imageUrl: $imageUrl, title: $title)';
}


}

/// @nodoc
abstract mixin class _$LinkPreviewCopyWith<$Res> implements $LinkPreviewCopyWith<$Res> {
  factory _$LinkPreviewCopyWith(_LinkPreview value, $Res Function(_LinkPreview) _then) = __$LinkPreviewCopyWithImpl;
@override @useResult
$Res call({
 String link, String? description, String? imageUrl, String? title
});




}
/// @nodoc
class __$LinkPreviewCopyWithImpl<$Res>
    implements _$LinkPreviewCopyWith<$Res> {
  __$LinkPreviewCopyWithImpl(this._self, this._then);

  final _LinkPreview _self;
  final $Res Function(_LinkPreview) _then;

/// Create a copy of LinkPreview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? link = null,Object? description = freezed,Object? imageUrl = freezed,Object? title = freezed,}) {
  return _then(_LinkPreview(
link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
