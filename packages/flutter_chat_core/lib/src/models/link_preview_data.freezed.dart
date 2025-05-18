// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'link_preview_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LinkPreviewData {

/// The original URL link.
 String get link;/// A description extracted from the link source.
 String? get description;/// The URL of an image associated with the link.
 String? get imageUrl;/// The image width.
 int? get imageWidth;/// The image height.
 int? get imageHeight;/// The title extracted from the link source.
 String? get title;
/// Create a copy of LinkPreviewData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LinkPreviewDataCopyWith<LinkPreviewData> get copyWith => _$LinkPreviewDataCopyWithImpl<LinkPreviewData>(this as LinkPreviewData, _$identity);

  /// Serializes this LinkPreviewData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LinkPreviewData&&(identical(other.link, link) || other.link == link)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.imageWidth, imageWidth) || other.imageWidth == imageWidth)&&(identical(other.imageHeight, imageHeight) || other.imageHeight == imageHeight)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,link,description,imageUrl,imageWidth,imageHeight,title);

@override
String toString() {
  return 'LinkPreviewData(link: $link, description: $description, imageUrl: $imageUrl, imageWidth: $imageWidth, imageHeight: $imageHeight, title: $title)';
}


}

/// @nodoc
abstract mixin class $LinkPreviewDataCopyWith<$Res>  {
  factory $LinkPreviewDataCopyWith(LinkPreviewData value, $Res Function(LinkPreviewData) _then) = _$LinkPreviewDataCopyWithImpl;
@useResult
$Res call({
 String link, String? description, String? imageUrl, int? imageWidth, int? imageHeight, String? title
});




}
/// @nodoc
class _$LinkPreviewDataCopyWithImpl<$Res>
    implements $LinkPreviewDataCopyWith<$Res> {
  _$LinkPreviewDataCopyWithImpl(this._self, this._then);

  final LinkPreviewData _self;
  final $Res Function(LinkPreviewData) _then;

/// Create a copy of LinkPreviewData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? link = null,Object? description = freezed,Object? imageUrl = freezed,Object? imageWidth = freezed,Object? imageHeight = freezed,Object? title = freezed,}) {
  return _then(_self.copyWith(
link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,imageWidth: freezed == imageWidth ? _self.imageWidth : imageWidth // ignore: cast_nullable_to_non_nullable
as int?,imageHeight: freezed == imageHeight ? _self.imageHeight : imageHeight // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _LinkPreviewData extends LinkPreviewData {
  const _LinkPreviewData({required this.link, this.description, this.imageUrl, this.imageWidth, this.imageHeight, this.title}): super._();
  factory _LinkPreviewData.fromJson(Map<String, dynamic> json) => _$LinkPreviewDataFromJson(json);

/// The original URL link.
@override final  String link;
/// A description extracted from the link source.
@override final  String? description;
/// The URL of an image associated with the link.
@override final  String? imageUrl;
/// The image width.
@override final  int? imageWidth;
/// The image height.
@override final  int? imageHeight;
/// The title extracted from the link source.
@override final  String? title;

/// Create a copy of LinkPreviewData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LinkPreviewDataCopyWith<_LinkPreviewData> get copyWith => __$LinkPreviewDataCopyWithImpl<_LinkPreviewData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LinkPreviewDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LinkPreviewData&&(identical(other.link, link) || other.link == link)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.imageWidth, imageWidth) || other.imageWidth == imageWidth)&&(identical(other.imageHeight, imageHeight) || other.imageHeight == imageHeight)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,link,description,imageUrl,imageWidth,imageHeight,title);

@override
String toString() {
  return 'LinkPreviewData(link: $link, description: $description, imageUrl: $imageUrl, imageWidth: $imageWidth, imageHeight: $imageHeight, title: $title)';
}


}

/// @nodoc
abstract mixin class _$LinkPreviewDataCopyWith<$Res> implements $LinkPreviewDataCopyWith<$Res> {
  factory _$LinkPreviewDataCopyWith(_LinkPreviewData value, $Res Function(_LinkPreviewData) _then) = __$LinkPreviewDataCopyWithImpl;
@override @useResult
$Res call({
 String link, String? description, String? imageUrl, int? imageWidth, int? imageHeight, String? title
});




}
/// @nodoc
class __$LinkPreviewDataCopyWithImpl<$Res>
    implements _$LinkPreviewDataCopyWith<$Res> {
  __$LinkPreviewDataCopyWithImpl(this._self, this._then);

  final _LinkPreviewData _self;
  final $Res Function(_LinkPreviewData) _then;

/// Create a copy of LinkPreviewData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? link = null,Object? description = freezed,Object? imageUrl = freezed,Object? imageWidth = freezed,Object? imageHeight = freezed,Object? title = freezed,}) {
  return _then(_LinkPreviewData(
link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,imageWidth: freezed == imageWidth ? _self.imageWidth : imageWidth // ignore: cast_nullable_to_non_nullable
as int?,imageHeight: freezed == imageHeight ? _self.imageHeight : imageHeight // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
