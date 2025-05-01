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
