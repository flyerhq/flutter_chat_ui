## 2.1.2

 - **FIX**: add audio message type. ([8d2b705a](https://github.com/flyerhq/flutter_chat_ui/commit/8d2b705ad261275368d8c92d91ccdd53193d58ca))

## 2.1.1

 - **FIX**: add video message type. ([93a13840](https://github.com/flyerhq/flutter_chat_ui/commit/93a13840c2ae3fae7e36093efeb4f9bf69e8a755))

## 2.1.0

 - **FEAT**: rename chat controller methods. ([dc1bf57d](https://github.com/flyerhq/flutter_chat_ui/commit/dc1bf57d9b5f9655805589fdda5581759b9cc1a9))

## 2.0.2

 - **FIX**: improve documentation and add example. ([113141b3](https://github.com/flyerhq/flutter_chat_ui/commit/113141b31de52a166eea54625f4cdd5b80bb897a))

## 2.0.1

 - **FIX**: document public APIs.

## 2.0.0

- First stable release, keep the same version as flutter_chat_ui

## 0.0.12

**⚠️ Breaking changes ⚠️**

- Updated the `Message` model to rename `parentId` to `replyToMessageId`
- The `createdAt` field is now optional in the message model
- The `sending` field has been removed from the message model; instead, you can set `sending: true` in the metadata of the Message model to achieve the same functionality.
- The `isOnlyEmoji` property has been removed from the text message model; to indicate that a message contains only emojis, use `isOnlyEmoji: true` in the metadata of the text message.
- The `firstName` and `lastName` fields in the `User` model have been consolidated into a single `name` field for improved simplicity.

**Other changes**

- Introduced `MessageID` and `UserID` typedefs to provide clearer context, while maintaining their underlying type as `String`s
- Introduced `TextStreamMessage` type to support text streaming
- Added `textStreamMessageBuilder` to the `Builders` class to support text streaming UI widget

## 0.0.11

**⚠️ Breaking changes ⚠️**

- Rename `inputBuilder` to `composerBuilder`

## 0.0.10

**⚠️ Breaking changes ⚠️**

- Requires Freezed 3.0.0
- Replace `status` field with a computed getter that determines message state based on lifecycle timestamps (`createdAt`, `deletedAt`, `sending`, `failedAt`, `sentAt`, `deliveredAt`, `seenAt`, `updatedAt`). This enables granular message history tracking and status transitions, matching the behavior of popular chat applications.
- Rename `overlay` to `hasOverlay` in `ImageMessage`

**Other changes**

- Downgrade `intl` package version for better compatibility with other Flutter packages

## 0.0.9

- Added system message for displaying system notifications and events in chat

## 0.0.8

- Add `UserCache` class to store resolved users for synchronous access, preventing flickering in recycled widgets by caching user data with LRU eviction strategy
- Add `ScrollToMessageMixin` to enable programmatic scrolling in chat list:
  - `scrollToMessage(messageId)`: Scrolls to a specific message by ID
  - `scrollToIndex(index)`: Scrolls to a message at a specific index
  - Both methods support customizable animation duration, curve, alignment and offset
  - Can be used directly through any `ChatController` instance
  - See the pagination example in the example project for usage details
- Add validation to prevent duplicate message IDs

## 0.0.7

- Require Flutter 3.29 and Dart 3.7

## 0.0.6

**⚠️ Breaking changes ⚠️**

- Changed signature of `chatMessageBuilder` to include `isRemoved` and `groupStatus` parameters.
- Changed `imageUrl` to `imageSource` for the `User` model. Change is necessary to show that not only remote URLs are supported but also local assets.

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
