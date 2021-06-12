---
id: types
title: Types
---

All types are in a separate package, [flutter_chat_types](https://pub.dev/packages/flutter_chat_types). There are 3 supported message types at the moment - `File`, `Image` and `Text`. All of them have corresponding "partial" message types, that include only the message's content. "Partial" messages are useful to create the content and then pass it to some kind of a backend service, which will assign fields like `id` or `author` etc, returning a "full" message which can be passed to the `messages` parameter of the `Chat` widget. In addition to that, there are `Custom` and `Unsupported` types. `Custom` can be used to build anything you want, and `Unsupported` is just a placeholder to have backwards compatibility. See the [API reference](https://pub.dev/documentation/flutter_chat_types/latest/index.html) for more info.
