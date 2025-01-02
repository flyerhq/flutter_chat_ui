## 0.0.4

- Added `isOnlyEmoji` parameter to `TextMessage`.
- Message builders now include the message index in their parameters.
- Reverted `withValues` to `withOpacity` to resolve a compatibility issue.

## 0.0.3

- Added `customMessageBuilder` for building custom messages
- Added `overlay` parameter to `ImageMessage`
- Themes:
  - Added `ImageMessageTheme` (replacing `imagePlaceholderColor`)
  - Updated `InputTheme` (adding `textFieldColor`)
  - Updated `ScrollToBottomTheme`
  - Updated `TextMessageTheme`
- Added `UploadProgressMixin` for handling upload progress tracking

## 0.0.2

- Bump version to support flutter_chat_ui v2 alpha release

## 0.0.1

- Initial release
