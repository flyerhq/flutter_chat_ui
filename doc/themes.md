---
id: themes
title: Themes
---

You can override anything from some defined theme or create a new one from scratch. See the theme implementation [here](https://github.com/flyerhq/flutter_chat_ui/blob/main/lib/src/chat_theme.dart). To override the theme partially, use any defined theme and change what is needed, like on this example:

```dart
@override
Widget build(BuildContext context) => Scaffold(
    body: Chat(
      theme: const DefaultChatTheme(
        inputBackgroundColor: Colors.red,
      ),
    ),
  );
```

If you created a theme from scratch just pass it to the `theme` parameter. We also provide `DarkChatTheme` implementation, you can pass it to the `theme` parameter.

[API reference](https://pub.dev/documentation/flutter_chat_ui/latest/flutter_chat_ui/ChatTheme-class.html).
