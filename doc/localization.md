---
id: localization
title: Localization
---

## Dates

To localize dates you can pass the `dateLocale` parameter to the `Chat` widget. This locale will be passed to [intl](https://pub.dev/packages/intl), so we can localize dates.

:::important

Before you can use a `dateLocale`, you need to initialize the [intl](https://pub.dev/packages/intl) date formatting. To do it you can:

1. Add `intl` to your `pubspec.yaml`.
2. Inside `main()` 

```dart
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}
```

This is the simplest solution, do your research if you want to handle it more gracefully.
:::

## Texts

You can override anything from some defined l10n or create a new one from scratch. See the l10n implementation [here](https://github.com/flyerhq/flutter_chat_ui/blob/main/lib/src/chat_l10n.dart). To override l10n partially, use any defined l10n and change what is needed, like on this example:

```dart
@override
Widget build(BuildContext context) => Scaffold(
    body: Chat(
      l10n: const ChatL10nEn(
        inputPlaceholder: 'Here',
      ),
    ),
  );
```

If you created a l10n from scratch just pass it to the `l10n` parameter. To see all available l10ns, check [API reference](https://pub.dev/documentation/flutter_chat_ui/latest/flutter_chat_ui/ChatL10n-class.html).
