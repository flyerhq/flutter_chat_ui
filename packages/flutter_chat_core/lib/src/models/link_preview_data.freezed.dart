// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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
 String? get description;/// The preview data of an image extracted from the link
 ImagePreviewData? get image;/// The title extracted from the link source.
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LinkPreviewData&&(identical(other.link, link) || other.link == link)&&(identical(other.description, description) || other.description == description)&&(identical(other.image, image) || other.image == image)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,link,description,image,title);

@override
String toString() {
  return 'LinkPreviewData(link: $link, description: $description, image: $image, title: $title)';
}


}

/// @nodoc
abstract mixin class $LinkPreviewDataCopyWith<$Res>  {
  factory $LinkPreviewDataCopyWith(LinkPreviewData value, $Res Function(LinkPreviewData) _then) = _$LinkPreviewDataCopyWithImpl;
@useResult
$Res call({
 String link, String? description, ImagePreviewData? image, String? title
});


$ImagePreviewDataCopyWith<$Res>? get image;

}
/// @nodoc
class _$LinkPreviewDataCopyWithImpl<$Res>
    implements $LinkPreviewDataCopyWith<$Res> {
  _$LinkPreviewDataCopyWithImpl(this._self, this._then);

  final LinkPreviewData _self;
  final $Res Function(LinkPreviewData) _then;

/// Create a copy of LinkPreviewData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? link = null,Object? description = freezed,Object? image = freezed,Object? title = freezed,}) {
  return _then(_self.copyWith(
link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as ImagePreviewData?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of LinkPreviewData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ImagePreviewDataCopyWith<$Res>? get image {
    if (_self.image == null) {
    return null;
  }

  return $ImagePreviewDataCopyWith<$Res>(_self.image!, (value) {
    return _then(_self.copyWith(image: value));
  });
}
}


/// Adds pattern-matching-related methods to [LinkPreviewData].
extension LinkPreviewDataPatterns on LinkPreviewData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LinkPreviewData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LinkPreviewData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LinkPreviewData value)  $default,){
final _that = this;
switch (_that) {
case _LinkPreviewData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LinkPreviewData value)?  $default,){
final _that = this;
switch (_that) {
case _LinkPreviewData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String link,  String? description,  ImagePreviewData? image,  String? title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LinkPreviewData() when $default != null:
return $default(_that.link,_that.description,_that.image,_that.title);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String link,  String? description,  ImagePreviewData? image,  String? title)  $default,) {final _that = this;
switch (_that) {
case _LinkPreviewData():
return $default(_that.link,_that.description,_that.image,_that.title);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String link,  String? description,  ImagePreviewData? image,  String? title)?  $default,) {final _that = this;
switch (_that) {
case _LinkPreviewData() when $default != null:
return $default(_that.link,_that.description,_that.image,_that.title);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LinkPreviewData extends LinkPreviewData {
  const _LinkPreviewData({required this.link, this.description, this.image, this.title}): super._();
  factory _LinkPreviewData.fromJson(Map<String, dynamic> json) => _$LinkPreviewDataFromJson(json);

/// The original URL link.
@override final  String link;
/// A description extracted from the link source.
@override final  String? description;
/// The preview data of an image extracted from the link
@override final  ImagePreviewData? image;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LinkPreviewData&&(identical(other.link, link) || other.link == link)&&(identical(other.description, description) || other.description == description)&&(identical(other.image, image) || other.image == image)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,link,description,image,title);

@override
String toString() {
  return 'LinkPreviewData(link: $link, description: $description, image: $image, title: $title)';
}


}

/// @nodoc
abstract mixin class _$LinkPreviewDataCopyWith<$Res> implements $LinkPreviewDataCopyWith<$Res> {
  factory _$LinkPreviewDataCopyWith(_LinkPreviewData value, $Res Function(_LinkPreviewData) _then) = __$LinkPreviewDataCopyWithImpl;
@override @useResult
$Res call({
 String link, String? description, ImagePreviewData? image, String? title
});


@override $ImagePreviewDataCopyWith<$Res>? get image;

}
/// @nodoc
class __$LinkPreviewDataCopyWithImpl<$Res>
    implements _$LinkPreviewDataCopyWith<$Res> {
  __$LinkPreviewDataCopyWithImpl(this._self, this._then);

  final _LinkPreviewData _self;
  final $Res Function(_LinkPreviewData) _then;

/// Create a copy of LinkPreviewData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? link = null,Object? description = freezed,Object? image = freezed,Object? title = freezed,}) {
  return _then(_LinkPreviewData(
link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as ImagePreviewData?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of LinkPreviewData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ImagePreviewDataCopyWith<$Res>? get image {
    if (_self.image == null) {
    return null;
  }

  return $ImagePreviewDataCopyWith<$Res>(_self.image!, (value) {
    return _then(_self.copyWith(image: value));
  });
}
}


/// @nodoc
mixin _$ImagePreviewData {

/// The URL of an image associated with the link.
 String get url;/// The image width.
 double get width;/// The image height.
 double get height;
/// Create a copy of ImagePreviewData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImagePreviewDataCopyWith<ImagePreviewData> get copyWith => _$ImagePreviewDataCopyWithImpl<ImagePreviewData>(this as ImagePreviewData, _$identity);

  /// Serializes this ImagePreviewData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImagePreviewData&&(identical(other.url, url) || other.url == url)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,width,height);

@override
String toString() {
  return 'ImagePreviewData(url: $url, width: $width, height: $height)';
}


}

/// @nodoc
abstract mixin class $ImagePreviewDataCopyWith<$Res>  {
  factory $ImagePreviewDataCopyWith(ImagePreviewData value, $Res Function(ImagePreviewData) _then) = _$ImagePreviewDataCopyWithImpl;
@useResult
$Res call({
 String url, double width, double height
});




}
/// @nodoc
class _$ImagePreviewDataCopyWithImpl<$Res>
    implements $ImagePreviewDataCopyWith<$Res> {
  _$ImagePreviewDataCopyWithImpl(this._self, this._then);

  final ImagePreviewData _self;
  final $Res Function(ImagePreviewData) _then;

/// Create a copy of ImagePreviewData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? width = null,Object? height = null,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ImagePreviewData].
extension ImagePreviewDataPatterns on ImagePreviewData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImagePreviewData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImagePreviewData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImagePreviewData value)  $default,){
final _that = this;
switch (_that) {
case _ImagePreviewData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImagePreviewData value)?  $default,){
final _that = this;
switch (_that) {
case _ImagePreviewData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  double width,  double height)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImagePreviewData() when $default != null:
return $default(_that.url,_that.width,_that.height);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  double width,  double height)  $default,) {final _that = this;
switch (_that) {
case _ImagePreviewData():
return $default(_that.url,_that.width,_that.height);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  double width,  double height)?  $default,) {final _that = this;
switch (_that) {
case _ImagePreviewData() when $default != null:
return $default(_that.url,_that.width,_that.height);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ImagePreviewData extends ImagePreviewData {
  const _ImagePreviewData({required this.url, required this.width, required this.height}): super._();
  factory _ImagePreviewData.fromJson(Map<String, dynamic> json) => _$ImagePreviewDataFromJson(json);

/// The URL of an image associated with the link.
@override final  String url;
/// The image width.
@override final  double width;
/// The image height.
@override final  double height;

/// Create a copy of ImagePreviewData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImagePreviewDataCopyWith<_ImagePreviewData> get copyWith => __$ImagePreviewDataCopyWithImpl<_ImagePreviewData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImagePreviewDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImagePreviewData&&(identical(other.url, url) || other.url == url)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,width,height);

@override
String toString() {
  return 'ImagePreviewData(url: $url, width: $width, height: $height)';
}


}

/// @nodoc
abstract mixin class _$ImagePreviewDataCopyWith<$Res> implements $ImagePreviewDataCopyWith<$Res> {
  factory _$ImagePreviewDataCopyWith(_ImagePreviewData value, $Res Function(_ImagePreviewData) _then) = __$ImagePreviewDataCopyWithImpl;
@override @useResult
$Res call({
 String url, double width, double height
});




}
/// @nodoc
class __$ImagePreviewDataCopyWithImpl<$Res>
    implements _$ImagePreviewDataCopyWith<$Res> {
  __$ImagePreviewDataCopyWithImpl(this._self, this._then);

  final _ImagePreviewData _self;
  final $Res Function(_ImagePreviewData) _then;

/// Create a copy of ImagePreviewData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? width = null,Object? height = null,}) {
  return _then(_ImagePreviewData(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
