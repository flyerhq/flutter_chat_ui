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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChatTheme value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChatTheme>(value),
    );
  }
}

String _$riverpodChatThemeHash() => r'6aca4ca92f1e2b134105893c6e4ec484b480cd77';

abstract class _$RiverpodChatTheme extends $Notifier<ChatTheme> {
  ChatTheme build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ChatTheme, ChatTheme>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ChatTheme, ChatTheme>,
              ChatTheme,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
