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
