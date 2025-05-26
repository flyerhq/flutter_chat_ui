import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../flutter_chat_core.dart';

part 'chat_theme_provider.g.dart';

// We define here a theme provider,
// We mark it as keepalive so it does not get destroyed id no widget watches it
@Riverpod(keepAlive: true)
class RiverpodChatTheme extends _$RiverpodChatTheme {
  @override
  ChatTheme build() {
    return ChatTheme.dark();
  }

  void setTheme(ChatTheme theme) {
    print('setTheme');
    state = theme;
  }
}
