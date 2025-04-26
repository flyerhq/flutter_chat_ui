// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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

 TextMessageBuilder? get textMessageBuilder; TextStreamMessageBuilder? get textStreamMessageBuilder; ImageMessageBuilder? get imageMessageBuilder; FileMessageBuilder? get fileMessageBuilder; SystemMessageBuilder? get systemMessageBuilder; CustomMessageBuilder? get customMessageBuilder; UnsupportedMessageBuilder? get unsupportedMessageBuilder; ComposerBuilder? get composerBuilder; ChatMessageBuilder? get chatMessageBuilder; ChatAnimatedListBuilder? get chatAnimatedListBuilder; ScrollToBottomBuilder? get scrollToBottomBuilder; LoadMoreBuilder? get loadMoreBuilder;
/// Create a copy of Builders
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BuildersCopyWith<Builders> get copyWith => _$BuildersCopyWithImpl<Builders>(this as Builders, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Builders&&(identical(other.textMessageBuilder, textMessageBuilder) || other.textMessageBuilder == textMessageBuilder)&&(identical(other.textStreamMessageBuilder, textStreamMessageBuilder) || other.textStreamMessageBuilder == textStreamMessageBuilder)&&(identical(other.imageMessageBuilder, imageMessageBuilder) || other.imageMessageBuilder == imageMessageBuilder)&&(identical(other.fileMessageBuilder, fileMessageBuilder) || other.fileMessageBuilder == fileMessageBuilder)&&(identical(other.systemMessageBuilder, systemMessageBuilder) || other.systemMessageBuilder == systemMessageBuilder)&&(identical(other.customMessageBuilder, customMessageBuilder) || other.customMessageBuilder == customMessageBuilder)&&(identical(other.unsupportedMessageBuilder, unsupportedMessageBuilder) || other.unsupportedMessageBuilder == unsupportedMessageBuilder)&&(identical(other.composerBuilder, composerBuilder) || other.composerBuilder == composerBuilder)&&(identical(other.chatMessageBuilder, chatMessageBuilder) || other.chatMessageBuilder == chatMessageBuilder)&&(identical(other.chatAnimatedListBuilder, chatAnimatedListBuilder) || other.chatAnimatedListBuilder == chatAnimatedListBuilder)&&(identical(other.scrollToBottomBuilder, scrollToBottomBuilder) || other.scrollToBottomBuilder == scrollToBottomBuilder)&&(identical(other.loadMoreBuilder, loadMoreBuilder) || other.loadMoreBuilder == loadMoreBuilder));
}


@override
int get hashCode => Object.hash(runtimeType,textMessageBuilder,textStreamMessageBuilder,imageMessageBuilder,fileMessageBuilder,systemMessageBuilder,customMessageBuilder,unsupportedMessageBuilder,composerBuilder,chatMessageBuilder,chatAnimatedListBuilder,scrollToBottomBuilder,loadMoreBuilder);

@override
String toString() {
  return 'Builders(textMessageBuilder: $textMessageBuilder, textStreamMessageBuilder: $textStreamMessageBuilder, imageMessageBuilder: $imageMessageBuilder, fileMessageBuilder: $fileMessageBuilder, systemMessageBuilder: $systemMessageBuilder, customMessageBuilder: $customMessageBuilder, unsupportedMessageBuilder: $unsupportedMessageBuilder, composerBuilder: $composerBuilder, chatMessageBuilder: $chatMessageBuilder, chatAnimatedListBuilder: $chatAnimatedListBuilder, scrollToBottomBuilder: $scrollToBottomBuilder, loadMoreBuilder: $loadMoreBuilder)';
}


}

/// @nodoc
abstract mixin class $BuildersCopyWith<$Res>  {
  factory $BuildersCopyWith(Builders value, $Res Function(Builders) _then) = _$BuildersCopyWithImpl;
@useResult
$Res call({
 TextMessageBuilder? textMessageBuilder, TextStreamMessageBuilder? textStreamMessageBuilder, ImageMessageBuilder? imageMessageBuilder, FileMessageBuilder? fileMessageBuilder, SystemMessageBuilder? systemMessageBuilder, CustomMessageBuilder? customMessageBuilder, UnsupportedMessageBuilder? unsupportedMessageBuilder, ComposerBuilder? composerBuilder, ChatMessageBuilder? chatMessageBuilder, ChatAnimatedListBuilder? chatAnimatedListBuilder, ScrollToBottomBuilder? scrollToBottomBuilder, LoadMoreBuilder? loadMoreBuilder
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
@pragma('vm:prefer-inline') @override $Res call({Object? textMessageBuilder = freezed,Object? textStreamMessageBuilder = freezed,Object? imageMessageBuilder = freezed,Object? fileMessageBuilder = freezed,Object? systemMessageBuilder = freezed,Object? customMessageBuilder = freezed,Object? unsupportedMessageBuilder = freezed,Object? composerBuilder = freezed,Object? chatMessageBuilder = freezed,Object? chatAnimatedListBuilder = freezed,Object? scrollToBottomBuilder = freezed,Object? loadMoreBuilder = freezed,}) {
  return _then(_self.copyWith(
textMessageBuilder: freezed == textMessageBuilder ? _self.textMessageBuilder : textMessageBuilder // ignore: cast_nullable_to_non_nullable
as TextMessageBuilder?,textStreamMessageBuilder: freezed == textStreamMessageBuilder ? _self.textStreamMessageBuilder : textStreamMessageBuilder // ignore: cast_nullable_to_non_nullable
as TextStreamMessageBuilder?,imageMessageBuilder: freezed == imageMessageBuilder ? _self.imageMessageBuilder : imageMessageBuilder // ignore: cast_nullable_to_non_nullable
as ImageMessageBuilder?,fileMessageBuilder: freezed == fileMessageBuilder ? _self.fileMessageBuilder : fileMessageBuilder // ignore: cast_nullable_to_non_nullable
as FileMessageBuilder?,systemMessageBuilder: freezed == systemMessageBuilder ? _self.systemMessageBuilder : systemMessageBuilder // ignore: cast_nullable_to_non_nullable
as SystemMessageBuilder?,customMessageBuilder: freezed == customMessageBuilder ? _self.customMessageBuilder : customMessageBuilder // ignore: cast_nullable_to_non_nullable
as CustomMessageBuilder?,unsupportedMessageBuilder: freezed == unsupportedMessageBuilder ? _self.unsupportedMessageBuilder : unsupportedMessageBuilder // ignore: cast_nullable_to_non_nullable
as UnsupportedMessageBuilder?,composerBuilder: freezed == composerBuilder ? _self.composerBuilder : composerBuilder // ignore: cast_nullable_to_non_nullable
as ComposerBuilder?,chatMessageBuilder: freezed == chatMessageBuilder ? _self.chatMessageBuilder : chatMessageBuilder // ignore: cast_nullable_to_non_nullable
as ChatMessageBuilder?,chatAnimatedListBuilder: freezed == chatAnimatedListBuilder ? _self.chatAnimatedListBuilder : chatAnimatedListBuilder // ignore: cast_nullable_to_non_nullable
as ChatAnimatedListBuilder?,scrollToBottomBuilder: freezed == scrollToBottomBuilder ? _self.scrollToBottomBuilder : scrollToBottomBuilder // ignore: cast_nullable_to_non_nullable
as ScrollToBottomBuilder?,loadMoreBuilder: freezed == loadMoreBuilder ? _self.loadMoreBuilder : loadMoreBuilder // ignore: cast_nullable_to_non_nullable
as LoadMoreBuilder?,
  ));
}

}


/// @nodoc


class _Builders extends Builders {
  const _Builders({this.textMessageBuilder, this.textStreamMessageBuilder, this.imageMessageBuilder, this.fileMessageBuilder, this.systemMessageBuilder, this.customMessageBuilder, this.unsupportedMessageBuilder, this.composerBuilder, this.chatMessageBuilder, this.chatAnimatedListBuilder, this.scrollToBottomBuilder, this.loadMoreBuilder}): super._();
  

@override final  TextMessageBuilder? textMessageBuilder;
@override final  TextStreamMessageBuilder? textStreamMessageBuilder;
@override final  ImageMessageBuilder? imageMessageBuilder;
@override final  FileMessageBuilder? fileMessageBuilder;
@override final  SystemMessageBuilder? systemMessageBuilder;
@override final  CustomMessageBuilder? customMessageBuilder;
@override final  UnsupportedMessageBuilder? unsupportedMessageBuilder;
@override final  ComposerBuilder? composerBuilder;
@override final  ChatMessageBuilder? chatMessageBuilder;
@override final  ChatAnimatedListBuilder? chatAnimatedListBuilder;
@override final  ScrollToBottomBuilder? scrollToBottomBuilder;
@override final  LoadMoreBuilder? loadMoreBuilder;

/// Create a copy of Builders
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BuildersCopyWith<_Builders> get copyWith => __$BuildersCopyWithImpl<_Builders>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Builders&&(identical(other.textMessageBuilder, textMessageBuilder) || other.textMessageBuilder == textMessageBuilder)&&(identical(other.textStreamMessageBuilder, textStreamMessageBuilder) || other.textStreamMessageBuilder == textStreamMessageBuilder)&&(identical(other.imageMessageBuilder, imageMessageBuilder) || other.imageMessageBuilder == imageMessageBuilder)&&(identical(other.fileMessageBuilder, fileMessageBuilder) || other.fileMessageBuilder == fileMessageBuilder)&&(identical(other.systemMessageBuilder, systemMessageBuilder) || other.systemMessageBuilder == systemMessageBuilder)&&(identical(other.customMessageBuilder, customMessageBuilder) || other.customMessageBuilder == customMessageBuilder)&&(identical(other.unsupportedMessageBuilder, unsupportedMessageBuilder) || other.unsupportedMessageBuilder == unsupportedMessageBuilder)&&(identical(other.composerBuilder, composerBuilder) || other.composerBuilder == composerBuilder)&&(identical(other.chatMessageBuilder, chatMessageBuilder) || other.chatMessageBuilder == chatMessageBuilder)&&(identical(other.chatAnimatedListBuilder, chatAnimatedListBuilder) || other.chatAnimatedListBuilder == chatAnimatedListBuilder)&&(identical(other.scrollToBottomBuilder, scrollToBottomBuilder) || other.scrollToBottomBuilder == scrollToBottomBuilder)&&(identical(other.loadMoreBuilder, loadMoreBuilder) || other.loadMoreBuilder == loadMoreBuilder));
}


@override
int get hashCode => Object.hash(runtimeType,textMessageBuilder,textStreamMessageBuilder,imageMessageBuilder,fileMessageBuilder,systemMessageBuilder,customMessageBuilder,unsupportedMessageBuilder,composerBuilder,chatMessageBuilder,chatAnimatedListBuilder,scrollToBottomBuilder,loadMoreBuilder);

@override
String toString() {
  return 'Builders(textMessageBuilder: $textMessageBuilder, textStreamMessageBuilder: $textStreamMessageBuilder, imageMessageBuilder: $imageMessageBuilder, fileMessageBuilder: $fileMessageBuilder, systemMessageBuilder: $systemMessageBuilder, customMessageBuilder: $customMessageBuilder, unsupportedMessageBuilder: $unsupportedMessageBuilder, composerBuilder: $composerBuilder, chatMessageBuilder: $chatMessageBuilder, chatAnimatedListBuilder: $chatAnimatedListBuilder, scrollToBottomBuilder: $scrollToBottomBuilder, loadMoreBuilder: $loadMoreBuilder)';
}


}

/// @nodoc
abstract mixin class _$BuildersCopyWith<$Res> implements $BuildersCopyWith<$Res> {
  factory _$BuildersCopyWith(_Builders value, $Res Function(_Builders) _then) = __$BuildersCopyWithImpl;
@override @useResult
$Res call({
 TextMessageBuilder? textMessageBuilder, TextStreamMessageBuilder? textStreamMessageBuilder, ImageMessageBuilder? imageMessageBuilder, FileMessageBuilder? fileMessageBuilder, SystemMessageBuilder? systemMessageBuilder, CustomMessageBuilder? customMessageBuilder, UnsupportedMessageBuilder? unsupportedMessageBuilder, ComposerBuilder? composerBuilder, ChatMessageBuilder? chatMessageBuilder, ChatAnimatedListBuilder? chatAnimatedListBuilder, ScrollToBottomBuilder? scrollToBottomBuilder, LoadMoreBuilder? loadMoreBuilder
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
@override @pragma('vm:prefer-inline') $Res call({Object? textMessageBuilder = freezed,Object? textStreamMessageBuilder = freezed,Object? imageMessageBuilder = freezed,Object? fileMessageBuilder = freezed,Object? systemMessageBuilder = freezed,Object? customMessageBuilder = freezed,Object? unsupportedMessageBuilder = freezed,Object? composerBuilder = freezed,Object? chatMessageBuilder = freezed,Object? chatAnimatedListBuilder = freezed,Object? scrollToBottomBuilder = freezed,Object? loadMoreBuilder = freezed,}) {
  return _then(_Builders(
textMessageBuilder: freezed == textMessageBuilder ? _self.textMessageBuilder : textMessageBuilder // ignore: cast_nullable_to_non_nullable
as TextMessageBuilder?,textStreamMessageBuilder: freezed == textStreamMessageBuilder ? _self.textStreamMessageBuilder : textStreamMessageBuilder // ignore: cast_nullable_to_non_nullable
as TextStreamMessageBuilder?,imageMessageBuilder: freezed == imageMessageBuilder ? _self.imageMessageBuilder : imageMessageBuilder // ignore: cast_nullable_to_non_nullable
as ImageMessageBuilder?,fileMessageBuilder: freezed == fileMessageBuilder ? _self.fileMessageBuilder : fileMessageBuilder // ignore: cast_nullable_to_non_nullable
as FileMessageBuilder?,systemMessageBuilder: freezed == systemMessageBuilder ? _self.systemMessageBuilder : systemMessageBuilder // ignore: cast_nullable_to_non_nullable
as SystemMessageBuilder?,customMessageBuilder: freezed == customMessageBuilder ? _self.customMessageBuilder : customMessageBuilder // ignore: cast_nullable_to_non_nullable
as CustomMessageBuilder?,unsupportedMessageBuilder: freezed == unsupportedMessageBuilder ? _self.unsupportedMessageBuilder : unsupportedMessageBuilder // ignore: cast_nullable_to_non_nullable
as UnsupportedMessageBuilder?,composerBuilder: freezed == composerBuilder ? _self.composerBuilder : composerBuilder // ignore: cast_nullable_to_non_nullable
as ComposerBuilder?,chatMessageBuilder: freezed == chatMessageBuilder ? _self.chatMessageBuilder : chatMessageBuilder // ignore: cast_nullable_to_non_nullable
as ChatMessageBuilder?,chatAnimatedListBuilder: freezed == chatAnimatedListBuilder ? _self.chatAnimatedListBuilder : chatAnimatedListBuilder // ignore: cast_nullable_to_non_nullable
as ChatAnimatedListBuilder?,scrollToBottomBuilder: freezed == scrollToBottomBuilder ? _self.scrollToBottomBuilder : scrollToBottomBuilder // ignore: cast_nullable_to_non_nullable
as ScrollToBottomBuilder?,loadMoreBuilder: freezed == loadMoreBuilder ? _self.loadMoreBuilder : loadMoreBuilder // ignore: cast_nullable_to_non_nullable
as LoadMoreBuilder?,
  ));
}


}

// dart format on
