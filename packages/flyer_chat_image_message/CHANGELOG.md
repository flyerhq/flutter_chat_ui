## 2.3.0

 - **FEAT**: update deps - requires min dart 3.8 and flutter 3.32 ([#871](https://github.com/flyerhq/flutter_chat_ui/issues/871)). ([588b34bd](https://github.com/flyerhq/flutter_chat_ui/commit/588b34bd398900c8f25ee69c574d1e35391af1d1))

## 2.2.2

 - Update a dependency to the latest release.

## 2.2.1

 - Update a dependency to the latest release.

## 2.2.0

 - **FIX**: update LICENSE. ([209a1292](https://github.com/flyerhq/flutter_chat_ui/commit/209a129297ebe7fd202e41273c9c0ddd52b8b983))
 - **FEAT**: allow for top widgets within the bubble ([#814](https://github.com/flyerhq/flutter_chat_ui/issues/814)). ([e267c27c](https://github.com/flyerhq/flutter_chat_ui/commit/e267c27ca2ac8541e4f7c4ba05ee38cecaa1f9b6))

## 2.1.13

 - Update a dependency to the latest release.

## 2.1.12

 - **FIX**: add missing errorBuilder for image ([#827](https://github.com/flyerhq/flutter_chat_ui/issues/827)). ([95ea8b6a](https://github.com/flyerhq/flutter_chat_ui/commit/95ea8b6ac228696d08a4124320a4a6b8745db7e9))

## 2.1.11

 - **FIX**: update dependencies. ([a8ff8b57](https://github.com/flyerhq/flutter_chat_ui/commit/a8ff8b573a25146d5c78b1014c9caa3126d1de40))

## 2.1.10

 - Update a dependency to the latest release.

## 2.1.9

 - **FIX**: introduce status field back ([#809](https://github.com/flyerhq/flutter_chat_ui/issues/809)). ([1aadf874](https://github.com/flyerhq/flutter_chat_ui/commit/1aadf8747d81672422a0e40363b0c2aeaa9e3efd))
 - **FIX**: update documentation. ([2ec05db2](https://github.com/flyerhq/flutter_chat_ui/commit/2ec05db24f3fb469658a3fd3a27a7c3c739826e9))
 - **FIX**: perf improvements ([#807](https://github.com/flyerhq/flutter_chat_ui/issues/807)). ([71e6d690](https://github.com/flyerhq/flutter_chat_ui/commit/71e6d69027d520c351b00c5e85e30cd97dabd321))

## 2.1.8

 - Update a dependency to the latest release.

## 2.1.7

 - **FIX**: expose headers for avatar and image message. ([0261ce1c](https://github.com/flyerhq/flutter_chat_ui/commit/0261ce1cbace258836f90c83d7d1348fc6253ab5))

## 2.1.6

 - Update a dependency to the latest release.

## 2.1.5

 - Update a dependency to the latest release.

## 2.1.4

 - **FIX**: allow custom ImageProvider ([#766](https://github.com/flyerhq/flutter_chat_ui/issues/766)). ([d99d556c](https://github.com/flyerhq/flutter_chat_ui/commit/d99d556c58d624f09c35d3c84d1d5de96a02fe9e))

## 2.1.3

 - Update a dependency to the latest release.

## 2.1.2

 - Update a dependency to the latest release.

## 2.1.1

 - Update a dependency to the latest release.

## 2.1.0

 - **FEAT**: rename chat controller methods. ([dc1bf57d](https://github.com/flyerhq/flutter_chat_ui/commit/dc1bf57d9b5f9655805589fdda5581759b9cc1a9))

## 2.0.2

 - **FIX**: improve documentation and add example. ([113141b3](https://github.com/flyerhq/flutter_chat_ui/commit/113141b31de52a166eea54625f4cdd5b80bb897a))

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

- Rename `overlay` to `hasOverlay` in `ImageMessage`

## 0.0.9

- Added message status indicators (delivered, error, seen, sending, sent)
- Added message timestamps with customizable format, position

## 0.0.8

- Version bump to match other packages

## 0.0.7

- Require Flutter 3.29 and Dart 3.7

## 0.0.6

- Version bump to match other packages

## 0.0.5

- Introduce new customization options

## 0.0.4

- Version bump to match other packages

## 0.0.3

- Theme now derives from `imageMessageTheme`
- Added an upload progress indicator
- Fixed default constraints
- Added an optional overlay to images

## 0.0.2

- Bump version to support flutter_chat_ui v2 alpha release

## 0.0.1

- Initial release
