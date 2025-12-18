## 2.6.0

 - **FEAT**: update deps - requires min dart 3.8 and flutter 3.32 ([#871](https://github.com/flyerhq/flutter_chat_ui/issues/871)). ([588b34bd](https://github.com/flyerhq/flutter_chat_ui/commit/588b34bd398900c8f25ee69c574d1e35391af1d1))

## 2.5.2

 - **FIX**: add support for linksDecoration, sentLinksDecorationColor, receivedLinksDecorationColor. ([b5b9e906](https://github.com/flyerhq/flutter_chat_ui/commit/b5b9e906fc94fc0b22b72a12eb3d71860e301323))
 - **FIX**: link color ([#858](https://github.com/flyerhq/flutter_chat_ui/issues/858)). ([bb9f814d](https://github.com/flyerhq/flutter_chat_ui/commit/bb9f814d8d7f6a0ff03b4788f892eec23c4bbb88))

## 2.5.1

 - Update a dependency to the latest release.

## 2.5.0

 - **FIX**: update LICENSE. ([209a1292](https://github.com/flyerhq/flutter_chat_ui/commit/209a129297ebe7fd202e41273c9c0ddd52b8b983))
 - **FEAT**: allow for top widgets within the bubble ([#814](https://github.com/flyerhq/flutter_chat_ui/issues/814)). ([e267c27c](https://github.com/flyerhq/flutter_chat_ui/commit/e267c27ca2ac8541e4f7c4ba05ee38cecaa1f9b6))

## 2.4.0

 - **FEAT**: link preview package ([#790](https://github.com/flyerhq/flutter_chat_ui/issues/790)). ([2938f646](https://github.com/flyerhq/flutter_chat_ui/commit/2938f646f3167fb9ab65ca769f2326801db45c52))

## 2.3.3

 - **FIX**: add onLinkTap for StreamMessages ([#831](https://github.com/flyerhq/flutter_chat_ui/issues/831)). ([c92d7e22](https://github.com/flyerhq/flutter_chat_ui/commit/c92d7e22ac82204f93d6c35fe20d954de53077c5))
 - **FIX**: allow set linksColor ([#830](https://github.com/flyerhq/flutter_chat_ui/issues/830)). ([a4044125](https://github.com/flyerhq/flutter_chat_ui/commit/a40441256914149b28174cc784ca190be4c03e19))

## 2.3.2

 - **FIX**: update dependencies. ([a8ff8b57](https://github.com/flyerhq/flutter_chat_ui/commit/a8ff8b573a25146d5c78b1014c9caa3126d1de40))

## 2.3.1

 - Update a dependency to the latest release.

## 2.3.0

 - **FIX**: introduce status field back ([#809](https://github.com/flyerhq/flutter_chat_ui/issues/809)). ([1aadf874](https://github.com/flyerhq/flutter_chat_ui/commit/1aadf8747d81672422a0e40363b0c2aeaa9e3efd))
 - **FIX**: update documentation. ([2ec05db2](https://github.com/flyerhq/flutter_chat_ui/commit/2ec05db24f3fb469658a3fd3a27a7c3c739826e9))
 - **FIX**: perf improvements ([#807](https://github.com/flyerhq/flutter_chat_ui/issues/807)). ([71e6d690](https://github.com/flyerhq/flutter_chat_ui/commit/71e6d69027d520c351b00c5e85e30cd97dabd321))
 - **FEAT**: time and status grouping same minute fix [#764](https://github.com/flyerhq/flutter_chat_ui/issues/764) ([#792](https://github.com/flyerhq/flutter_chat_ui/issues/792)). ([61c04002](https://github.com/flyerhq/flutter_chat_ui/commit/61c04002153897113f47c239e059511b1e3468ec))

## 2.2.2

 - Update a dependency to the latest release.

## 2.2.1

 - Update a dependency to the latest release.

## 2.2.0

 - **FEAT**: link preview v2 ([#784](https://github.com/flyerhq/flutter_chat_ui/issues/784)). ([b65060e1](https://github.com/flyerhq/flutter_chat_ui/commit/b65060e11036402934489976c702dab28c7feb80))

## 2.1.5

 - Update a dependency to the latest release.

## 2.1.4

 - **FIX**: add tap callback function for the GptMarkdown link ([#781](https://github.com/flyerhq/flutter_chat_ui/issues/781)). ([89998bfe](https://github.com/flyerhq/flutter_chat_ui/commit/89998bfe081c9d46b6beb8f286176aac66033afa))

## 2.1.3

 - Update a dependency to the latest release.

## 2.1.2

 - Update a dependency to the latest release.

## 2.1.1

 - Update a dependency to the latest release.

## 2.1.0

 - **FEAT**: rename chat controller methods. ([dc1bf57d](https://github.com/flyerhq/flutter_chat_ui/commit/dc1bf57d9b5f9655805589fdda5581759b9cc1a9))

## 2.0.4

 - Update a dependency to the latest release.

## 2.0.3

 - **FIX**: improve documentation. ([19ce9641](https://github.com/flyerhq/flutter_chat_ui/commit/19ce9641d341cd297cd83219e989914e7bc78af0))

## 2.0.2

 - **FIX**: improve documentation. ([19ce9641](https://github.com/flyerhq/flutter_chat_ui/commit/19ce9641d341cd297cd83219e989914e7bc78af0))

## 2.0.1

 - **FIX**: document public APIs.

## 2.0.0

- First stable release

## 0.0.12

**⚠️ Breaking Changes ⚠️**

- The default sentinel values that previously allowed users to set specific properties to `null` have been removed. Instead, please use `Colors.transparent`, `BorderRadius.zero`, or `TextStyle()` to achieve the desired effect. Passing `null` will now use the standard configuration.

- Do not show status for received messages

## 0.0.11

- Version bump to match other packages

## 0.0.10

- Version bump to match other packages

## 0.0.9

- Added message status indicators (delivered, error, seen, sending, sent)
- Added message timestamps with customizable format, position

## 0.0.8

- Changed `flutter_markdown` to `gpt_markdown`

## 0.0.7

- Require Flutter 3.29 and Dart 3.7

## 0.0.6

- Version bump to match other packages

## 0.0.5

- Introduce new customization options

## 0.0.4

- Text messages containing only emojis will now be displayed without a bubble

## 0.0.3

- Version bump to match other packages

## 0.0.2

- Bump version to support flutter_chat_ui v2 alpha release

## 0.0.1

- Initial release
