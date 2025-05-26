// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(RiverpodChatTheme)
const riverpodChatThemeProvider = RiverpodChatThemeProvider._();

final class RiverpodChatThemeProvider
    extends $NotifierProvider<RiverpodChatTheme, ChatTheme> {
  const RiverpodChatThemeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'riverpodChatThemeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$riverpodChatThemeHash();

  @$internal
  @override
  RiverpodChatTheme create() => RiverpodChatTheme();

  @$internal
  @override
  $NotifierProviderElement<RiverpodChatTheme, ChatTheme> $createElement(
    $ProviderPointer pointer,
  ) => $NotifierProviderElement(pointer);

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChatTheme value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<ChatTheme>(value),
    );
  }
}

String _$riverpodChatThemeHash() => r'e67d0e4d6814483eb4b1aff78e4f91e77d4297b4';

abstract class _$RiverpodChatTheme extends $Notifier<ChatTheme> {
  ChatTheme build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ChatTheme>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ChatTheme>,
              ChatTheme,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
