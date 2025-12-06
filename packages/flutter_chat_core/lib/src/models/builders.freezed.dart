// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'builders.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Builders {

/// Custom builder for text messages.
 TextMessageBuilder? get textMessageBuilder;/// Custom builder for streaming text messages.
 TextStreamMessageBuilder? get textStreamMessageBuilder;/// Custom builder for image messages.
 ImageMessageBuilder? get imageMessageBuilder;/// Custom builder for file messages.
 FileMessageBuilder? get fileMessageBuilder;/// Custom builder for video messages.
 VideoMessageBuilder? get videoMessageBuilder;/// Custom builder for audio messages.
 AudioMessageBuilder? get audioMessageBuilder;/// Custom builder for system messages.
 SystemMessageBuilder? get systemMessageBuilder;/// Custom builder for custom message types.
 CustomMessageBuilder? get customMessageBuilder;/// Custom builder for unsupported message types.
 UnsupportedMessageBuilder? get unsupportedMessageBuilder;/// Custom builder for the message composer.
 ComposerBuilder? get composerBuilder;/// Custom builder for the wrapper around each chat message.
 ChatMessageBuilder? get chatMessageBuilder;/// Custom builder for the main chat list.
 ChatAnimatedListBuilder? get chatAnimatedListBuilder;/// Custom builder for the "scroll to bottom" button.
 ScrollToBottomBuilder? get scrollToBottomBuilder;/// Custom builder for the load more indicator.
 LoadMoreBuilder? get loadMoreBuilder;/// Custom builder for the empty chat list.
 EmptyChatListBuilder? get emptyChatListBuilder;/// Custom builder for the link preview widget.
 LinkPreviewBuilder? get linkPreviewBuilder;
/// Create a copy of Builders
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BuildersCopyWith<Builders> get copyWith => _$BuildersCopyWithImpl<Builders>(this as Builders, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Builders&&(identical(other.textMessageBuilder, textMessageBuilder) || other.textMessageBuilder == textMessageBuilder)&&(identical(other.textStreamMessageBuilder, textStreamMessageBuilder) || other.textStreamMessageBuilder == textStreamMessageBuilder)&&(identical(other.imageMessageBuilder, imageMessageBuilder) || other.imageMessageBuilder == imageMessageBuilder)&&(identical(other.fileMessageBuilder, fileMessageBuilder) || other.fileMessageBuilder == fileMessageBuilder)&&(identical(other.videoMessageBuilder, videoMessageBuilder) || other.videoMessageBuilder == videoMessageBuilder)&&(identical(other.audioMessageBuilder, audioMessageBuilder) || other.audioMessageBuilder == audioMessageBuilder)&&(identical(other.systemMessageBuilder, systemMessageBuilder) || other.systemMessageBuilder == systemMessageBuilder)&&(identical(other.customMessageBuilder, customMessageBuilder) || other.customMessageBuilder == customMessageBuilder)&&(identical(other.unsupportedMessageBuilder, unsupportedMessageBuilder) || other.unsupportedMessageBuilder == unsupportedMessageBuilder)&&(identical(other.composerBuilder, composerBuilder) || other.composerBuilder == composerBuilder)&&(identical(other.chatMessageBuilder, chatMessageBuilder) || other.chatMessageBuilder == chatMessageBuilder)&&(identical(other.chatAnimatedListBuilder, chatAnimatedListBuilder) || other.chatAnimatedListBuilder == chatAnimatedListBuilder)&&(identical(other.scrollToBottomBuilder, scrollToBottomBuilder) || other.scrollToBottomBuilder == scrollToBottomBuilder)&&(identical(other.loadMoreBuilder, loadMoreBuilder) || other.loadMoreBuilder == loadMoreBuilder)&&(identical(other.emptyChatListBuilder, emptyChatListBuilder) || other.emptyChatListBuilder == emptyChatListBuilder)&&(identical(other.linkPreviewBuilder, linkPreviewBuilder) || other.linkPreviewBuilder == linkPreviewBuilder));
}


@override
int get hashCode => Object.hash(runtimeType,textMessageBuilder,textStreamMessageBuilder,imageMessageBuilder,fileMessageBuilder,videoMessageBuilder,audioMessageBuilder,systemMessageBuilder,customMessageBuilder,unsupportedMessageBuilder,composerBuilder,chatMessageBuilder,chatAnimatedListBuilder,scrollToBottomBuilder,loadMoreBuilder,emptyChatListBuilder,linkPreviewBuilder);

@override
String toString() {
  return 'Builders(textMessageBuilder: $textMessageBuilder, textStreamMessageBuilder: $textStreamMessageBuilder, imageMessageBuilder: $imageMessageBuilder, fileMessageBuilder: $fileMessageBuilder, videoMessageBuilder: $videoMessageBuilder, audioMessageBuilder: $audioMessageBuilder, systemMessageBuilder: $systemMessageBuilder, customMessageBuilder: $customMessageBuilder, unsupportedMessageBuilder: $unsupportedMessageBuilder, composerBuilder: $composerBuilder, chatMessageBuilder: $chatMessageBuilder, chatAnimatedListBuilder: $chatAnimatedListBuilder, scrollToBottomBuilder: $scrollToBottomBuilder, loadMoreBuilder: $loadMoreBuilder, emptyChatListBuilder: $emptyChatListBuilder, linkPreviewBuilder: $linkPreviewBuilder)';
}


}

/// @nodoc
abstract mixin class $BuildersCopyWith<$Res>  {
  factory $BuildersCopyWith(Builders value, $Res Function(Builders) _then) = _$BuildersCopyWithImpl;
@useResult
$Res call({
 TextMessageBuilder? textMessageBuilder, TextStreamMessageBuilder? textStreamMessageBuilder, ImageMessageBuilder? imageMessageBuilder, FileMessageBuilder? fileMessageBuilder, VideoMessageBuilder? videoMessageBuilder, AudioMessageBuilder? audioMessageBuilder, SystemMessageBuilder? systemMessageBuilder, CustomMessageBuilder? customMessageBuilder, UnsupportedMessageBuilder? unsupportedMessageBuilder, ComposerBuilder? composerBuilder, ChatMessageBuilder? chatMessageBuilder, ChatAnimatedListBuilder? chatAnimatedListBuilder, ScrollToBottomBuilder? scrollToBottomBuilder, LoadMoreBuilder? loadMoreBuilder, EmptyChatListBuilder? emptyChatListBuilder, LinkPreviewBuilder? linkPreviewBuilder
});




}
/// @nodoc
class _$BuildersCopyWithImpl<$Res>
    implements $BuildersCopyWith<$Res> {
  _$BuildersCopyWithImpl(this._self, this._then);

  final Builders _self;
  final $Res Function(Builders) _then;

/// Create a copy of Builders
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? textMessageBuilder = freezed,Object? textStreamMessageBuilder = freezed,Object? imageMessageBuilder = freezed,Object? fileMessageBuilder = freezed,Object? videoMessageBuilder = freezed,Object? audioMessageBuilder = freezed,Object? systemMessageBuilder = freezed,Object? customMessageBuilder = freezed,Object? unsupportedMessageBuilder = freezed,Object? composerBuilder = freezed,Object? chatMessageBuilder = freezed,Object? chatAnimatedListBuilder = freezed,Object? scrollToBottomBuilder = freezed,Object? loadMoreBuilder = freezed,Object? emptyChatListBuilder = freezed,Object? linkPreviewBuilder = freezed,}) {
  return _then(_self.copyWith(
textMessageBuilder: freezed == textMessageBuilder ? _self.textMessageBuilder : textMessageBuilder // ignore: cast_nullable_to_non_nullable
as TextMessageBuilder?,textStreamMessageBuilder: freezed == textStreamMessageBuilder ? _self.textStreamMessageBuilder : textStreamMessageBuilder // ignore: cast_nullable_to_non_nullable
as TextStreamMessageBuilder?,imageMessageBuilder: freezed == imageMessageBuilder ? _self.imageMessageBuilder : imageMessageBuilder // ignore: cast_nullable_to_non_nullable
as ImageMessageBuilder?,fileMessageBuilder: freezed == fileMessageBuilder ? _self.fileMessageBuilder : fileMessageBuilder // ignore: cast_nullable_to_non_nullable
as FileMessageBuilder?,videoMessageBuilder: freezed == videoMessageBuilder ? _self.videoMessageBuilder : videoMessageBuilder // ignore: cast_nullable_to_non_nullable
as VideoMessageBuilder?,audioMessageBuilder: freezed == audioMessageBuilder ? _self.audioMessageBuilder : audioMessageBuilder // ignore: cast_nullable_to_non_nullable
as AudioMessageBuilder?,systemMessageBuilder: freezed == systemMessageBuilder ? _self.systemMessageBuilder : systemMessageBuilder // ignore: cast_nullable_to_non_nullable
as SystemMessageBuilder?,customMessageBuilder: freezed == customMessageBuilder ? _self.customMessageBuilder : customMessageBuilder // ignore: cast_nullable_to_non_nullable
as CustomMessageBuilder?,unsupportedMessageBuilder: freezed == unsupportedMessageBuilder ? _self.unsupportedMessageBuilder : unsupportedMessageBuilder // ignore: cast_nullable_to_non_nullable
as UnsupportedMessageBuilder?,composerBuilder: freezed == composerBuilder ? _self.composerBuilder : composerBuilder // ignore: cast_nullable_to_non_nullable
as ComposerBuilder?,chatMessageBuilder: freezed == chatMessageBuilder ? _self.chatMessageBuilder : chatMessageBuilder // ignore: cast_nullable_to_non_nullable
as ChatMessageBuilder?,chatAnimatedListBuilder: freezed == chatAnimatedListBuilder ? _self.chatAnimatedListBuilder : chatAnimatedListBuilder // ignore: cast_nullable_to_non_nullable
as ChatAnimatedListBuilder?,scrollToBottomBuilder: freezed == scrollToBottomBuilder ? _self.scrollToBottomBuilder : scrollToBottomBuilder // ignore: cast_nullable_to_non_nullable
as ScrollToBottomBuilder?,loadMoreBuilder: freezed == loadMoreBuilder ? _self.loadMoreBuilder : loadMoreBuilder // ignore: cast_nullable_to_non_nullable
as LoadMoreBuilder?,emptyChatListBuilder: freezed == emptyChatListBuilder ? _self.emptyChatListBuilder : emptyChatListBuilder // ignore: cast_nullable_to_non_nullable
as EmptyChatListBuilder?,linkPreviewBuilder: freezed == linkPreviewBuilder ? _self.linkPreviewBuilder : linkPreviewBuilder // ignore: cast_nullable_to_non_nullable
as LinkPreviewBuilder?,
  ));
}

}


/// Adds pattern-matching-related methods to [Builders].
extension BuildersPatterns on Builders {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Builders value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Builders() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Builders value)  $default,){
final _that = this;
switch (_that) {
case _Builders():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Builders value)?  $default,){
final _that = this;
switch (_that) {
case _Builders() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TextMessageBuilder? textMessageBuilder,  TextStreamMessageBuilder? textStreamMessageBuilder,  ImageMessageBuilder? imageMessageBuilder,  FileMessageBuilder? fileMessageBuilder,  VideoMessageBuilder? videoMessageBuilder,  AudioMessageBuilder? audioMessageBuilder,  SystemMessageBuilder? systemMessageBuilder,  CustomMessageBuilder? customMessageBuilder,  UnsupportedMessageBuilder? unsupportedMessageBuilder,  ComposerBuilder? composerBuilder,  ChatMessageBuilder? chatMessageBuilder,  ChatAnimatedListBuilder? chatAnimatedListBuilder,  ScrollToBottomBuilder? scrollToBottomBuilder,  LoadMoreBuilder? loadMoreBuilder,  EmptyChatListBuilder? emptyChatListBuilder,  LinkPreviewBuilder? linkPreviewBuilder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Builders() when $default != null:
return $default(_that.textMessageBuilder,_that.textStreamMessageBuilder,_that.imageMessageBuilder,_that.fileMessageBuilder,_that.videoMessageBuilder,_that.audioMessageBuilder,_that.systemMessageBuilder,_that.customMessageBuilder,_that.unsupportedMessageBuilder,_that.composerBuilder,_that.chatMessageBuilder,_that.chatAnimatedListBuilder,_that.scrollToBottomBuilder,_that.loadMoreBuilder,_that.emptyChatListBuilder,_that.linkPreviewBuilder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TextMessageBuilder? textMessageBuilder,  TextStreamMessageBuilder? textStreamMessageBuilder,  ImageMessageBuilder? imageMessageBuilder,  FileMessageBuilder? fileMessageBuilder,  VideoMessageBuilder? videoMessageBuilder,  AudioMessageBuilder? audioMessageBuilder,  SystemMessageBuilder? systemMessageBuilder,  CustomMessageBuilder? customMessageBuilder,  UnsupportedMessageBuilder? unsupportedMessageBuilder,  ComposerBuilder? composerBuilder,  ChatMessageBuilder? chatMessageBuilder,  ChatAnimatedListBuilder? chatAnimatedListBuilder,  ScrollToBottomBuilder? scrollToBottomBuilder,  LoadMoreBuilder? loadMoreBuilder,  EmptyChatListBuilder? emptyChatListBuilder,  LinkPreviewBuilder? linkPreviewBuilder)  $default,) {final _that = this;
switch (_that) {
case _Builders():
return $default(_that.textMessageBuilder,_that.textStreamMessageBuilder,_that.imageMessageBuilder,_that.fileMessageBuilder,_that.videoMessageBuilder,_that.audioMessageBuilder,_that.systemMessageBuilder,_that.customMessageBuilder,_that.unsupportedMessageBuilder,_that.composerBuilder,_that.chatMessageBuilder,_that.chatAnimatedListBuilder,_that.scrollToBottomBuilder,_that.loadMoreBuilder,_that.emptyChatListBuilder,_that.linkPreviewBuilder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TextMessageBuilder? textMessageBuilder,  TextStreamMessageBuilder? textStreamMessageBuilder,  ImageMessageBuilder? imageMessageBuilder,  FileMessageBuilder? fileMessageBuilder,  VideoMessageBuilder? videoMessageBuilder,  AudioMessageBuilder? audioMessageBuilder,  SystemMessageBuilder? systemMessageBuilder,  CustomMessageBuilder? customMessageBuilder,  UnsupportedMessageBuilder? unsupportedMessageBuilder,  ComposerBuilder? composerBuilder,  ChatMessageBuilder? chatMessageBuilder,  ChatAnimatedListBuilder? chatAnimatedListBuilder,  ScrollToBottomBuilder? scrollToBottomBuilder,  LoadMoreBuilder? loadMoreBuilder,  EmptyChatListBuilder? emptyChatListBuilder,  LinkPreviewBuilder? linkPreviewBuilder)?  $default,) {final _that = this;
switch (_that) {
case _Builders() when $default != null:
return $default(_that.textMessageBuilder,_that.textStreamMessageBuilder,_that.imageMessageBuilder,_that.fileMessageBuilder,_that.videoMessageBuilder,_that.audioMessageBuilder,_that.systemMessageBuilder,_that.customMessageBuilder,_that.unsupportedMessageBuilder,_that.composerBuilder,_that.chatMessageBuilder,_that.chatAnimatedListBuilder,_that.scrollToBottomBuilder,_that.loadMoreBuilder,_that.emptyChatListBuilder,_that.linkPreviewBuilder);case _:
  return null;

}
}

}

/// @nodoc


class _Builders extends Builders {
  const _Builders({this.textMessageBuilder, this.textStreamMessageBuilder, this.imageMessageBuilder, this.fileMessageBuilder, this.videoMessageBuilder, this.audioMessageBuilder, this.systemMessageBuilder, this.customMessageBuilder, this.unsupportedMessageBuilder, this.composerBuilder, this.chatMessageBuilder, this.chatAnimatedListBuilder, this.scrollToBottomBuilder, this.loadMoreBuilder, this.emptyChatListBuilder, this.linkPreviewBuilder}): super._();
  

/// Custom builder for text messages.
@override final  TextMessageBuilder? textMessageBuilder;
/// Custom builder for streaming text messages.
@override final  TextStreamMessageBuilder? textStreamMessageBuilder;
/// Custom builder for image messages.
@override final  ImageMessageBuilder? imageMessageBuilder;
/// Custom builder for file messages.
@override final  FileMessageBuilder? fileMessageBuilder;
/// Custom builder for video messages.
@override final  VideoMessageBuilder? videoMessageBuilder;
/// Custom builder for audio messages.
@override final  AudioMessageBuilder? audioMessageBuilder;
/// Custom builder for system messages.
@override final  SystemMessageBuilder? systemMessageBuilder;
/// Custom builder for custom message types.
@override final  CustomMessageBuilder? customMessageBuilder;
/// Custom builder for unsupported message types.
@override final  UnsupportedMessageBuilder? unsupportedMessageBuilder;
/// Custom builder for the message composer.
@override final  ComposerBuilder? composerBuilder;
/// Custom builder for the wrapper around each chat message.
@override final  ChatMessageBuilder? chatMessageBuilder;
/// Custom builder for the main chat list.
@override final  ChatAnimatedListBuilder? chatAnimatedListBuilder;
/// Custom builder for the "scroll to bottom" button.
@override final  ScrollToBottomBuilder? scrollToBottomBuilder;
/// Custom builder for the load more indicator.
@override final  LoadMoreBuilder? loadMoreBuilder;
/// Custom builder for the empty chat list.
@override final  EmptyChatListBuilder? emptyChatListBuilder;
/// Custom builder for the link preview widget.
@override final  LinkPreviewBuilder? linkPreviewBuilder;

/// Create a copy of Builders
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BuildersCopyWith<_Builders> get copyWith => __$BuildersCopyWithImpl<_Builders>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Builders&&(identical(other.textMessageBuilder, textMessageBuilder) || other.textMessageBuilder == textMessageBuilder)&&(identical(other.textStreamMessageBuilder, textStreamMessageBuilder) || other.textStreamMessageBuilder == textStreamMessageBuilder)&&(identical(other.imageMessageBuilder, imageMessageBuilder) || other.imageMessageBuilder == imageMessageBuilder)&&(identical(other.fileMessageBuilder, fileMessageBuilder) || other.fileMessageBuilder == fileMessageBuilder)&&(identical(other.videoMessageBuilder, videoMessageBuilder) || other.videoMessageBuilder == videoMessageBuilder)&&(identical(other.audioMessageBuilder, audioMessageBuilder) || other.audioMessageBuilder == audioMessageBuilder)&&(identical(other.systemMessageBuilder, systemMessageBuilder) || other.systemMessageBuilder == systemMessageBuilder)&&(identical(other.customMessageBuilder, customMessageBuilder) || other.customMessageBuilder == customMessageBuilder)&&(identical(other.unsupportedMessageBuilder, unsupportedMessageBuilder) || other.unsupportedMessageBuilder == unsupportedMessageBuilder)&&(identical(other.composerBuilder, composerBuilder) || other.composerBuilder == composerBuilder)&&(identical(other.chatMessageBuilder, chatMessageBuilder) || other.chatMessageBuilder == chatMessageBuilder)&&(identical(other.chatAnimatedListBuilder, chatAnimatedListBuilder) || other.chatAnimatedListBuilder == chatAnimatedListBuilder)&&(identical(other.scrollToBottomBuilder, scrollToBottomBuilder) || other.scrollToBottomBuilder == scrollToBottomBuilder)&&(identical(other.loadMoreBuilder, loadMoreBuilder) || other.loadMoreBuilder == loadMoreBuilder)&&(identical(other.emptyChatListBuilder, emptyChatListBuilder) || other.emptyChatListBuilder == emptyChatListBuilder)&&(identical(other.linkPreviewBuilder, linkPreviewBuilder) || other.linkPreviewBuilder == linkPreviewBuilder));
}


@override
int get hashCode => Object.hash(runtimeType,textMessageBuilder,textStreamMessageBuilder,imageMessageBuilder,fileMessageBuilder,videoMessageBuilder,audioMessageBuilder,systemMessageBuilder,customMessageBuilder,unsupportedMessageBuilder,composerBuilder,chatMessageBuilder,chatAnimatedListBuilder,scrollToBottomBuilder,loadMoreBuilder,emptyChatListBuilder,linkPreviewBuilder);

@override
String toString() {
  return 'Builders(textMessageBuilder: $textMessageBuilder, textStreamMessageBuilder: $textStreamMessageBuilder, imageMessageBuilder: $imageMessageBuilder, fileMessageBuilder: $fileMessageBuilder, videoMessageBuilder: $videoMessageBuilder, audioMessageBuilder: $audioMessageBuilder, systemMessageBuilder: $systemMessageBuilder, customMessageBuilder: $customMessageBuilder, unsupportedMessageBuilder: $unsupportedMessageBuilder, composerBuilder: $composerBuilder, chatMessageBuilder: $chatMessageBuilder, chatAnimatedListBuilder: $chatAnimatedListBuilder, scrollToBottomBuilder: $scrollToBottomBuilder, loadMoreBuilder: $loadMoreBuilder, emptyChatListBuilder: $emptyChatListBuilder, linkPreviewBuilder: $linkPreviewBuilder)';
}


}

/// @nodoc
abstract mixin class _$BuildersCopyWith<$Res> implements $BuildersCopyWith<$Res> {
  factory _$BuildersCopyWith(_Builders value, $Res Function(_Builders) _then) = __$BuildersCopyWithImpl;
@override @useResult
$Res call({
 TextMessageBuilder? textMessageBuilder, TextStreamMessageBuilder? textStreamMessageBuilder, ImageMessageBuilder? imageMessageBuilder, FileMessageBuilder? fileMessageBuilder, VideoMessageBuilder? videoMessageBuilder, AudioMessageBuilder? audioMessageBuilder, SystemMessageBuilder? systemMessageBuilder, CustomMessageBuilder? customMessageBuilder, UnsupportedMessageBuilder? unsupportedMessageBuilder, ComposerBuilder? composerBuilder, ChatMessageBuilder? chatMessageBuilder, ChatAnimatedListBuilder? chatAnimatedListBuilder, ScrollToBottomBuilder? scrollToBottomBuilder, LoadMoreBuilder? loadMoreBuilder, EmptyChatListBuilder? emptyChatListBuilder, LinkPreviewBuilder? linkPreviewBuilder
});




}
/// @nodoc
class __$BuildersCopyWithImpl<$Res>
    implements _$BuildersCopyWith<$Res> {
  __$BuildersCopyWithImpl(this._self, this._then);

  final _Builders _self;
  final $Res Function(_Builders) _then;

/// Create a copy of Builders
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? textMessageBuilder = freezed,Object? textStreamMessageBuilder = freezed,Object? imageMessageBuilder = freezed,Object? fileMessageBuilder = freezed,Object? videoMessageBuilder = freezed,Object? audioMessageBuilder = freezed,Object? systemMessageBuilder = freezed,Object? customMessageBuilder = freezed,Object? unsupportedMessageBuilder = freezed,Object? composerBuilder = freezed,Object? chatMessageBuilder = freezed,Object? chatAnimatedListBuilder = freezed,Object? scrollToBottomBuilder = freezed,Object? loadMoreBuilder = freezed,Object? emptyChatListBuilder = freezed,Object? linkPreviewBuilder = freezed,}) {
  return _then(_Builders(
textMessageBuilder: freezed == textMessageBuilder ? _self.textMessageBuilder : textMessageBuilder // ignore: cast_nullable_to_non_nullable
as TextMessageBuilder?,textStreamMessageBuilder: freezed == textStreamMessageBuilder ? _self.textStreamMessageBuilder : textStreamMessageBuilder // ignore: cast_nullable_to_non_nullable
as TextStreamMessageBuilder?,imageMessageBuilder: freezed == imageMessageBuilder ? _self.imageMessageBuilder : imageMessageBuilder // ignore: cast_nullable_to_non_nullable
as ImageMessageBuilder?,fileMessageBuilder: freezed == fileMessageBuilder ? _self.fileMessageBuilder : fileMessageBuilder // ignore: cast_nullable_to_non_nullable
as FileMessageBuilder?,videoMessageBuilder: freezed == videoMessageBuilder ? _self.videoMessageBuilder : videoMessageBuilder // ignore: cast_nullable_to_non_nullable
as VideoMessageBuilder?,audioMessageBuilder: freezed == audioMessageBuilder ? _self.audioMessageBuilder : audioMessageBuilder // ignore: cast_nullable_to_non_nullable
as AudioMessageBuilder?,systemMessageBuilder: freezed == systemMessageBuilder ? _self.systemMessageBuilder : systemMessageBuilder // ignore: cast_nullable_to_non_nullable
as SystemMessageBuilder?,customMessageBuilder: freezed == customMessageBuilder ? _self.customMessageBuilder : customMessageBuilder // ignore: cast_nullable_to_non_nullable
as CustomMessageBuilder?,unsupportedMessageBuilder: freezed == unsupportedMessageBuilder ? _self.unsupportedMessageBuilder : unsupportedMessageBuilder // ignore: cast_nullable_to_non_nullable
as UnsupportedMessageBuilder?,composerBuilder: freezed == composerBuilder ? _self.composerBuilder : composerBuilder // ignore: cast_nullable_to_non_nullable
as ComposerBuilder?,chatMessageBuilder: freezed == chatMessageBuilder ? _self.chatMessageBuilder : chatMessageBuilder // ignore: cast_nullable_to_non_nullable
as ChatMessageBuilder?,chatAnimatedListBuilder: freezed == chatAnimatedListBuilder ? _self.chatAnimatedListBuilder : chatAnimatedListBuilder // ignore: cast_nullable_to_non_nullable
as ChatAnimatedListBuilder?,scrollToBottomBuilder: freezed == scrollToBottomBuilder ? _self.scrollToBottomBuilder : scrollToBottomBuilder // ignore: cast_nullable_to_non_nullable
as ScrollToBottomBuilder?,loadMoreBuilder: freezed == loadMoreBuilder ? _self.loadMoreBuilder : loadMoreBuilder // ignore: cast_nullable_to_non_nullable
as LoadMoreBuilder?,emptyChatListBuilder: freezed == emptyChatListBuilder ? _self.emptyChatListBuilder : emptyChatListBuilder // ignore: cast_nullable_to_non_nullable
as EmptyChatListBuilder?,linkPreviewBuilder: freezed == linkPreviewBuilder ? _self.linkPreviewBuilder : linkPreviewBuilder // ignore: cast_nullable_to_non_nullable
as LinkPreviewBuilder?,
  ));
}


}

// dart format on
