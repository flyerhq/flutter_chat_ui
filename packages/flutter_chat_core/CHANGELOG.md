## 0.0.5

**⚠️ Breaking changes ⚠️**

🔄 Core Changes:
- `author` (type `User`) is replaced with `authorId` (type `String`) for simpler user management
- All `DateTime` properties now use milliseconds instead of microseconds for JSON serialization

🎨 Theme Simplification:
Theme has been streamlined to 3 key parameters:
1. `colors` - Uses Material 3 semantic names (e.g. `primary`, `onPrimary`, `secondary`) making it easy to apply color schemes
2. `typography` - Follows Flutter's `TextTheme` semantic naming conventions
3. `shape` - Controls border radius of all messages (rounded vs square messages)

✨ Enhanced Customization:
- Individual widget customization available through the `builders` parameter
- Example: `loadMoreBuilder: (context) => LoadMore(color: Colors.red)` overrides theme colors
- Full widget customization possible by returning custom widgets from builders

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
