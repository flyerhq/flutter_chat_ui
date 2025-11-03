## 2.9.1

 - **FIX**: add content insertion configuration to Composer widget ([#852](https://github.com/flyerhq/flutter_chat_ui/issues/852)). ([6b5f6afc](https://github.com/flyerhq/flutter_chat_ui/commit/6b5f6afcd55054b79c31d950be63c2a4583f8128))

## 2.9.0

This release introduces two-sided pagination. You can now load newer messages using the new `onStartReached` callback, while `onEndReached` continues to work for older messages. For pagination to work correctly, messages should be inserted instantly, without animation.

To allow this and offer more granular control, a new optional `animated` parameter has been added to all controller operations except `update`. This is not a breaking change, but if you'd like to use it, you can update your controller like so:
```dart
insertMessage(Message message, {int? index}) // ❌
insertMessage(Message message, {int? index, bool animated = true}) // ✅
ChatOperation.insert(..., animated: animated) // add animated to insert operations

insertAllMessages(List<Message> messages, {int? index}) // ❌
insertAllMessages(List<Message> messages, {int? index, bool animated = true}) // ✅
ChatOperation.insertAll(..., animated: animated) // add animated to insertAll operations

removeMessage(Message message) // ❌
removeMessage(Message message, {bool animated = true}) // ✅
ChatOperation.remove(..., animated: animated) // add animated to remove operations

setMessages(List<Message> messages) // ❌
setMessages(List<Message> messages, {bool animated = true}) // ✅
ChatOperation.set(..., animated: animated) // add animated to set operations
```

As an optional improvement, you can use this parameter to disable animations when clearing the chat, which is now the default behaviour in the example apps.
```dart
ChatOperation.set(messages, animated: messages.isEmpty ? false : animated) // inside the controller
```

⚠️ There is a small potential breaking change: `LoadMoreNotifier` was updated for two-sided loading. If you used a custom **LoadMore** widget and used `LoadMoreNotifier` to measure its height, that logic has been removed as it was not used. Additionally, the internal property `_isLoading` is now `_isLoadingOlder`, and `_isLoadingNewer` has been added.

 - **FEAT**: implement two-sided pagination ([#840](https://github.com/flyerhq/flutter_chat_ui/issues/840)). ([8cca3141](https://github.com/flyerhq/flutter_chat_ui/commit/8cca314116664216b9f1697fabde0eccfd1c582d))

## 2.8.1

 - **FIX**: composer inputClearMode and fix custom editing controller. ([b4872190](https://github.com/flyerhq/flutter_chat_ui/commit/b4872190e92c5eae27dbd7c2bfa352f12085b527))

## 2.8.0

 - **FIX**: update LICENSE. ([209a1292](https://github.com/flyerhq/flutter_chat_ui/commit/209a129297ebe7fd202e41273c9c0ddd52b8b983))
 - **FEAT**: allow for top widgets within the bubble ([#814](https://github.com/flyerhq/flutter_chat_ui/issues/814)). ([e267c27c](https://github.com/flyerhq/flutter_chat_ui/commit/e267c27ca2ac8541e4f7c4ba05ee38cecaa1f9b6))

## 2.7.0

 - **FEAT**: link preview package ([#790](https://github.com/flyerhq/flutter_chat_ui/issues/790)). ([2938f646](https://github.com/flyerhq/flutter_chat_ui/commit/2938f646f3167fb9ab65ca769f2326801db45c52))

## 2.6.2

 - **FIX**: new loadingBuilder for stream message. ([38d539ac](https://github.com/flyerhq/flutter_chat_ui/commit/38d539ac7480392d223885a3378deee2b86b5966))

## 2.6.1

 - **FIX**: add sendButtonDisabled and sendButtonHidden [#828](https://github.com/flyerhq/flutter_chat_ui/issues/828). ([d476dd45](https://github.com/flyerhq/flutter_chat_ui/commit/d476dd4502df51148621577f9c66843cd3a067ab))

## 2.6.0

 - **FIX**: scrollToIndex does not work when starting with an empty list [#793](https://github.com/flyerhq/flutter_chat_ui/issues/793). ([1948c1f5](https://github.com/flyerhq/flutter_chat_ui/commit/1948c1f5c421d40ee8d276230eec295ca6b41d05))
 - **FEAT**: add sendButtonVisibilityMode and allowEmptyMessage to the composer. ([7a496607](https://github.com/flyerhq/flutter_chat_ui/commit/7a496607966f0e976ccefdc80ac5b42e4bf59f8f))
 - **FEAT**: add method OnMessageDoubleTapCallback; add param BuildContext context for OnMessageTapCallback and OnMessageLongPressCallback ([#817](https://github.com/flyerhq/flutter_chat_ui/issues/817)). ([6fe68886](https://github.com/flyerhq/flutter_chat_ui/commit/6fe688866c631a4976ec85e9adda210c58457d21))

## 2.5.3

 - **FIX**: update dependencies. ([a8ff8b57](https://github.com/flyerhq/flutter_chat_ui/commit/a8ff8b573a25146d5c78b1014c9caa3126d1de40))

## 2.5.2

 - Update a dependency to the latest release.

## 2.5.1

 - **FIX**: re-enable composer blur. ([791f7308](https://github.com/flyerhq/flutter_chat_ui/commit/791f7308cb499e854a6f59dc95a19ca9de7ef88d))

## 2.5.0

 - **FIX**: introduce status field back ([#809](https://github.com/flyerhq/flutter_chat_ui/issues/809)). ([1aadf874](https://github.com/flyerhq/flutter_chat_ui/commit/1aadf8747d81672422a0e40363b0c2aeaa9e3efd))
 - **FIX**: prevent sending blank messages ([#808](https://github.com/flyerhq/flutter_chat_ui/issues/808)). ([6fbcfc73](https://github.com/flyerhq/flutter_chat_ui/commit/6fbcfc73645ec5f704fb1add52f0862bc19bc129))
 - **FIX**: perf improvements ([#807](https://github.com/flyerhq/flutter_chat_ui/issues/807)). ([71e6d690](https://github.com/flyerhq/flutter_chat_ui/commit/71e6d69027d520c351b00c5e85e30cd97dabd321))
 - **FIX**: allow to set a different color in Composer when not empty ([#794](https://github.com/flyerhq/flutter_chat_ui/issues/794)). ([788ca0c6](https://github.com/flyerhq/flutter_chat_ui/commit/788ca0c6ce470b10d70ef8965b49150e7e8570f9))
 - **FEAT**: time and status grouping same minute fix [#764](https://github.com/flyerhq/flutter_chat_ui/issues/764) ([#792](https://github.com/flyerhq/flutter_chat_ui/issues/792)). ([61c04002](https://github.com/flyerhq/flutter_chat_ui/commit/61c04002153897113f47c239e059511b1e3468ec))

## 2.4.0

 - **FEAT**: expose isSentByMe and groupStatus in all messages builders ([#805](https://github.com/flyerhq/flutter_chat_ui/issues/805)). ([263d145b](https://github.com/flyerhq/flutter_chat_ui/commit/263d145bc3998d0f6ebed02406dda35634439b03))

## 2.3.1

 - **FIX**: add username widget. ([892ee622](https://github.com/flyerhq/flutter_chat_ui/commit/892ee6220273431ef90f51ce305c06dcca6944f7))
 - **FIX**: expose user_cache and make it a changenotifier. ([baa7eee6](https://github.com/flyerhq/flutter_chat_ui/commit/baa7eee65201507eaf05574c8fcbd9afb9120d4a))
 - **FIX**: expose headers for avatar and image message. ([0261ce1c](https://github.com/flyerhq/flutter_chat_ui/commit/0261ce1cbace258836f90c83d7d1348fc6253ab5))
 - **FIX**: gemini example with option to stop a stream. ([fa558e46](https://github.com/flyerhq/flutter_chat_ui/commit/fa558e4631708dd590468f8a0ea4cf2dcb1e68fc))

## 2.3.0

 - **FEAT**: link preview v2 ([#784](https://github.com/flyerhq/flutter_chat_ui/issues/784)). ([b65060e1](https://github.com/flyerhq/flutter_chat_ui/commit/b65060e11036402934489976c702dab28c7feb80))

## 2.2.4

 - **FIX**: add physics param to the ChatAnimatedList(Reversed). ([ede3a170](https://github.com/flyerhq/flutter_chat_ui/commit/ede3a1709ea3d496e906925efa863a13b54d84bc))
 - **FIX**: emptyChatList not clickable ([#787](https://github.com/flyerhq/flutter_chat_ui/issues/787)). ([88937baa](https://github.com/flyerhq/flutter_chat_ui/commit/88937baa657c5ca0842e77190756e521453f04cf))

## 2.2.3

 - **FIX**: add emptyChatListWidget ([#771](https://github.com/flyerhq/flutter_chat_ui/issues/771)). ([69954654](https://github.com/flyerhq/flutter_chat_ui/commit/699546546ca4df7d4271316b52332364fde55ed8))

## 2.2.2

 - **FIX**: scroll to bottom button appearance threshold [#769](https://github.com/flyerhq/flutter_chat_ui/issues/769) ([#774](https://github.com/flyerhq/flutter_chat_ui/issues/774)). ([e97d5c13](https://github.com/flyerhq/flutter_chat_ui/commit/e97d5c13b6461bde91a6ac55ffeb1c7f302b5415))

## 2.2.1

 - **FIX**: list rebuilding when keyboard opens/closes. ([48e28e7e](https://github.com/flyerhq/flutter_chat_ui/commit/48e28e7e2e5f36d27dcec8d0532b1d697684c541))

## 2.2.0

**⚠️ Breaking Changes ⚠️**

- **`ChatAnimatedList` Redesign**:
    - Significantly overhauled for robust handling of asynchronous controller updates.
    - The `update` operation (`ChatOperation.update`) now requires the `index` of the message to be updated.
- **CRITICAL**: When implementing custom `ChatController`s, you **MUST** now fetch the most up-to-date message instance from your data source *before* passing it to `remove` or `update` operations. The internal list now relies on the exact object reference. Failing to do so will lead to errors or unexpected behavior. (See `InMemoryChatController` for an example of fetching the actual message before emitting `ChatOperation.remove` or `ChatOperation.update`).

**✨ Key Enhancements & Fixes ✨**

- **Asynchronous Operations**: `ChatAnimatedList` now uses an internal operation queue to serialize updates, preventing race conditions and resolving prior `StreamOperation` issues.
- **List Factorization**: Common logic between normal and reversed `ChatAnimatedList` instances has been factorized, improving maintainability.
- **Bulk Insertions**: Added `insertAllMessages` to `ChatController` and `ChatAnimatedList` for efficient bulk message additions with animations.
- **Diffing & Stability**: `ChatController`'s `setMessages` now uses an improved `DiffUtil` (with move support), fixing "out of bounds" errors during complex list updates.
- **Data Consistency**: The controller now fetches the latest message version before updates or deletions to ensure operations use current data.
- **Bug Fixes**:
    - Corrected message insertion position in reversed lists ([#754](https://github.com/flyerhq/flutter_chat_ui/issues/754), [#755](https://github.com/flyerhq/flutter_chat_ui/issues/755)).
    - Ensured message update operations are correctly persisted ([#778](https://github.com/flyerhq/flutter_chat_ui/issues/778)).
- **Testing**: Introduced integration tests for `ChatAnimatedList` to validate list operations and item positioning.

---

 - **FIX**: update operation not persisted in the list ([#778](https://github.com/flyerhq/flutter_chat_ui/issues/778)). ([37472015](https://github.com/flyerhq/flutter_chat_ui/commit/374720152912648643c03f761b0a27eafcf0a46f))
 - **FEAT**: Fix StreamOperation Async issues / create insertAll / fixInsert on reverted list ([#756](https://github.com/flyerhq/flutter_chat_ui/issues/756)). ([60395f9b](https://github.com/flyerhq/flutter_chat_ui/commit/60395f9ba97ac4b8000aea70c7040d55bb40b6aa))

## 2.1.3

 - **FIX**: hide attachmentButton if no there is no onAttachmentTap provided ([#757](https://github.com/flyerhq/flutter_chat_ui/issues/757)). ([2eae2002](https://github.com/flyerhq/flutter_chat_ui/commit/2eae2002a9c846062902d7582724d0a932fae623))

## 2.1.2

 - **FIX**: add audio message type. ([8d2b705a](https://github.com/flyerhq/flutter_chat_ui/commit/8d2b705ad261275368d8c92d91ccdd53193d58ca))

## 2.1.1

 - **FIX**: add video message type. ([93a13840](https://github.com/flyerhq/flutter_chat_ui/commit/93a13840c2ae3fae7e36093efeb4f9bf69e8a755))

## 2.1.0

**⚠️ Breaking Changes ⚠️**

Chat controller methods have been renamed to avoid name conflicts with Riverpod.

- `insert` -> `insertMessage`
- `update` -> `updateMessage`
- `remove` -> `removeMessage`
- `set` -> `setMessages`

 - **FEAT**: rename chat controller methods. ([dc1bf57d](https://github.com/flyerhq/flutter_chat_ui/commit/dc1bf57d9b5f9655805589fdda5581759b9cc1a9))

## 2.0.2

 - **FIX**: improve documentation and add example. ([113141b3](https://github.com/flyerhq/flutter_chat_ui/commit/113141b31de52a166eea54625f4cdd5b80bb897a))

## 2.0.1

 - **FIX**: document public APIs.

## 2.0.0

- Version 2.0.0 is a major update where we completely rebuilt the library. This version focuses on better performance, more customization options, and improved stability. We have added many new features and improvements to make your experience better. For more details, check out our blog post: https://flyer.chat/blog/v2-announcement/ 🚀

## 2.0.0-dev.11

**⚠️ Breaking Changes ⚠️**

- Enhanced pagination functionality for the `ChatAnimatedList` widget. If you utilize the `paginationThreshold` parameter, please refer to the comments in the `ChatAnimatedList` widget implementation for detailed guidance.
- Updated the `Message` model to rename `parentId` to `replyToMessageId`
- The `createdAt` field is now optional in the message model
- The `sending` field has been removed from the message model; instead, you can set `sending: true` in the metadata of the Message model to achieve the same functionality.
- The `isOnlyEmoji` property has been removed from the text message model; to indicate that a message contains only emojis, use `isOnlyEmoji: true` in the metadata of the text message.
- The `firstName` and `lastName` fields in the `User` model have been consolidated into a single `name` field for improved simplicity.
- The default sentinel values that previously allowed users to set specific properties to `null` have been removed. Instead, please use `Colors.transparent`, `BorderRadius.zero`, or `TextStyle()` to achieve the desired effect. Passing `null` will now use the standard configuration.

**⚠️ New Features ⚠️**

- Added a `headerWidget` to the `ChatMessage` widget, enabling the display of a custom header for each message. You have the flexibility to control the header's position; wrap it with a `Center` widget for centering.
- Introduced new parameters: `sentMessageColumnAlignment`, `receivedMessageColumnAlignment`, `sentMessageRowAlignment`, and `receivedMessageRowAlignment` for the `ChatMessage` widget. These allow for precise control over the positioning of `leadingWidget`, `trailingWidget`, `topWidget`, and `bottomWidget`. Ensure correct defaults are set for proper alignment, especially when using the `topWidget`.
- Introduced `TextStreamMessage` type to support text streaming
- Added `textStreamMessageBuilder` to the `Builders` class to support text streaming UI widget

**Other changes**

- Introduced `MessageID` and `UserID` typedefs to provide clearer context, while maintaining their underlying type as `String`s
- Do not show status for received messages
- Added example for text streaming

## 2.0.0-dev.10

**⚠️ Breaking Changes ⚠️**

- Rename `ChatInput` to `Composer`
- Rename `ChatInputHeightNotifier` to `ComposerHeightNotifier`
- Rename `inputBuilder` to `composerBuilder`

## 2.0.0-dev.9

**⚠️ Breaking Changes ⚠️**

- Requires Freezed 3.0.0
- Replace `status` field with a computed getter that determines message state based on lifecycle timestamps (`createdAt`, `deletedAt`, `sending`, `failedAt`, `sentAt`, `deliveredAt`, `seenAt`, `updatedAt`). This enables granular message history tracking and status transitions, matching the behavior of popular chat applications.
- Rename `overlay` to `hasOverlay` in `ImageMessage`

**Other changes**

- Downgrade `intl` package version for better compatibility with other Flutter packages
- Added `FileMessage` support to the example project
- Migrated web storage implementation from `indexed_db` to `idb_shim` for improved cross-platform compatibility and better performance

## 2.0.0-dev.8

**⚠️ Breaking Changes ⚠️**

- Package requires `intl` package for date/time formatting

**⚠️ New features ⚠️**

- Added support for long press actions on messages with customizable callback
- Added system message for displaying system notifications and events in chat
- Added examples demonstrating both long press handling and system messages
- Added message status indicators (delivered, error, seen, sending, sent)
- Added message timestamps with customizable format, position

## 2.0.0-dev.7

**⚠️ Breaking Changes ⚠️**

- Changed dependency from `flutter_markdown` to `gpt_markdown` for the `FlyerChatTextMessage` class
- `onMessageTap` callback now includes message index and tap up details - updated parameters to `(Message item, {int? index, TapUpDetails? details})`
- Added more customization options to `ChatInput`, with default capitalization set to sentences
- Changed default behavior of Enter key in `ChatInput` to create a newline instead of sending message
  - To send message on Enter, set `textInputAction: TextInputAction.send` when configuring `ChatInput` through builders
  - See `local.dart` example for how to use builders to customize input behavior

**⚠️ New features ⚠️**

- Add `ScrollToMessageMixin` to enable programmatic scrolling in chat list:
  - `scrollToMessage(messageId)`: Scrolls to a specific message by ID
  - `scrollToIndex(index)`: Scrolls to a message at a specific index
  - Both methods support customizable animation duration, curve, alignment and offset
  - Can be used directly through any `ChatController` instance
  - See the pagination example in the example project for usage details
- Add validation to prevent duplicate message IDs
- Added support for sending messages using Shift+Enter keyboard shortcut in ChatInput

**🐛 Bug Fixes**

- Fixed flickering in avatar widget by implementing a user cache with LRU eviction strategy, allowing synchronous access to recently resolved user data

## 2.0.0-dev.6

**⚠️ Breaking changes ⚠️**

- Require Flutter 3.29 and Dart 3.7

**🐛 Bug Fixes**

- Temporarily disabled blur effect for chat input due to a crash in Flutter 3.29 (will be re-enabled once fix is available in stable)
- Fixed a warning that occurred when removing all messages simultaneously

## 2.0.0-dev.5

**⚠️ Breaking changes ⚠️**

- Changed signature of `chatMessageBuilder` to include `isRemoved` and `groupStatus` parameters.
- Changed `imageUrl` to `imageSource` for the `User` model. Change is necessary to show that not only remote URLs are supported but also local assets.
- `messageGroupingTimeoutInSeconds` is now set via `chatAnimatedListBuilder`.

**⚠️ New features ⚠️**

- Add `hintText` to the `ChatInput` widget.
- Added avatar support. Check local example for details.
- `chatMessageBuilder` now returns `isRemoved` and `groupStatus` parameters. Group status returns information about message's position in the group. `isRemoved` is `true` if message is removed.
- Added `leadingWidget` and `trailingWidget` to the `ChatMessage` widget.

## 2.0.0-dev.4

**⚠️ Breaking Changes ⚠️**

👥 User Management:
- Replaced `user` parameter with `currentUserId` (String) and `resolveUser` function
- Users are now referenced by ID, with async user data resolution through `resolveUser`

⚙️ API Changes:
- Renamed `ChatInputHeightNotifier.updateHeight()` to `setHeight()`
- Scroll controller management moved to individual list widgets that you can render via `builders`: `chatAnimatedListBuilder: ... return ChatAnimatedList(scrollController: _scrollController)`
- Text editing controller now configured through `ChatInput` widget

🔄 Core Changes:
- `author` (type `User`) is replaced with `authorId` (type `String`) for simpler user management
- All `DateTime` properties now use milliseconds instead of microseconds for JSON serialization

🎨 Theme Simplification:
Theme has been streamlined to 3 key parameters:
1. `colors` - Uses Material 3 semantic names (e.g. `primary`, `onPrimary`, `secondary`) making it easy to apply color schemes
2. `typography` - Follows Flutter's `TextTheme` semantic naming conventions
3. `shape` - Controls border radius of all messages (rounded vs square messages)

✨ New Features:

👨‍💻 Chat Experience:
- Added typing indicator support
- Background image customization
- Improved scroll-to-bottom performance

📜 List Behavior Controls:
- `shouldScrollToEndWhenSendingMessage`: Auto-scroll on message send
- `shouldScrollToEndWhenAtBottom`: Auto-scroll when at bottom
- `initialScrollToEndMode`: Controls initial scroll behavior for non-reversed list. Because list is not reversed, you must scroll to the end to see latest messages. Available options:
  - `none`: No automatic scrolling, do nothing
  - `animate`: Smooth scroll to end
  - `jump`: Instant scroll to end (wrong position or UI jumps are expected since Flutter does not know exact size of the list)

🎯 Improvements:
- Improved AI agent scrolling behavior example with message pinned to the top of the viewport
- Unified API between reversed and non-reversed lists
- Added pagination example

## 2.0.0-dev.3

**⚠️ Contains breaking changes ⚠️**

- 🎉 Emoji-only messages: added support for text messages containing only emojis, displayed without a bubble.
- 🧩 Message grouping: added support for grouping messages for a cleaner chat display.
- 🐛 Bug fix: fixed an issue where timeouts were not being cleared properly.
- 🔧 Chat builders: chat message builders now include the message index in their parameters.
- 📱 Safe area: added safe area support for reversed lists.

## 2.0.0-dev.2

**⚠️ Contains breaking changes ⚠️**

**⚠️ Requires Flutter ^3.19 and Dart ^3.3 ⚠️**

### 🖼️ API Example

- Added support for image uploads
- Added a web sockets connection status indicator with reconnection logic examples

### 🔗 cross-cache

- Added new methods:
  - `delete(String key)` – delete entries
  - `updateKey(String key, String newKey)` – rename keys while keeping the data
- `CustomNetworkImage` is now `CachedNetworkImage` and has been moved to the cross-cache package
- Exposed the `set` method for better flexibility

### 💬 flutter-chat-core

- Added `customMessageBuilder` for building custom messages
- Added `overlay` parameter to `ImageMessage`
- Themes:
  - Added `ImageMessageTheme` (replacing `imagePlaceholderColor`)
  - Updated `InputTheme` (adding `textFieldColor`)
  - Updated `ScrollToBottomTheme`
  - Updated `TextMessageTheme`
- Added `UploadProgressMixin` for handling upload progress tracking

### 📝 flutter-chat-ui

- Automatically handles the safe area (optional, enabled by default)
- Scrolls content up when the keyboard is opened
- Added support for an action bar above the input field (with example)
- Exported `ChatInputHeightNotifier`
- Enhanced `ChatAnimatedList` with:
  - `topSliver` and `bottomSliver` for custom widgets at the top or bottom of the chat (both scrollable)

### 📸 flyer-chat-image-message

- Theme now derives from `imageMessageTheme`
- Added an upload progress indicator
- Fixed default constraints
- Added an optional overlay to images

## 2.0.0-dev.1

- 🚀 Exciting pre-release of `v2`! This version is a complete rewrite, focusing on extensibility, customizability, performance, and stability. 🛠️
- ⚠️ Some features are still in progress, so use with caution. However, I've aimed to make this version more practical for real-world applications. 💼
- 🌟 New examples include integrations with REST API and AI (Gemini), with more to come! 🤖
- 💻 Works seamlessly across all platforms. 📱🖥️
- 📚 Documentation and migration guide are in the works and will be available in the coming weeks.
- 🗓️ A public backlog for the new version is planned to keep everyone informed about upcoming features.
- 🔔 Stay tuned by following our GitHub for updates!
- 🙏 If you have a chance to test `v2` or review the code, I'd love to hear your thoughts! 💬

## 1.6.15

- Last release of `v1` and `v2` is replacing it on main branch soon.
- Updated markdown matchers to be **bold** (double asterisk), _italic_ (double underscore), ~~linethrough~~ (double tilde) and `code` (single backtick).
- Removed PopScope since new api requires Flutter v3.22 and I want to still support older versions. Let me know if it introduces breaking behaviour.
- Added support for AssetImage (uri starts with `assets/`). Thanks @thomers for the PR!

## 1.6.14

- While `v2` is still in the works (unexpected blockers, see GitHub for progress) releasing a small patch update with improvements.
- Added optional scroll `preferPosition` to `scrollController.scrollToIndex`. Thanks @chdo002 for the PR!
- Removed `isComposingRangeValid` check from the input to hopefully fix send button that does not appear.
- Added `usesSafeArea` option to the `inputOptions` to be able to remove safe area backed inside the input.

## 1.6.13

- While `v2` is still in the works (unexpected blockers, see GitHub for progress) releasing a small patch update with improvements.
- **Potentially breaking: bumped dependencies**, but I used ranges (>= and <) so don't expect any problems. Please raise an issue if some change breaks your project.
- Added support for overriding the `bubbleMargin` property using `ChatTheme`. Thanks @ishchhabra for the PR!
- Added localisation support to the typing indicator which was hardcoded english only previously. Thanks @longnh2k1 for raising the issue!

## 1.6.12

- Remove `defaultBubbleMessage` from the `bubbleBuilder` as it breaks compatibility. If you need this please use previous release, this is the only change here. Next should be v2.0.0 preview.

## 1.6.11

- Small patch release while 2.0.0 is still in the works.
- Added `messageMaxWidth` to the theme. Thanks @bobz392 for the PR!
- Added `isLeftStatus` to display status on the left side of the message. Thanks @hndrr for the PR!
- Added localisation for Persian language (fa locale). Thanks @xclud for the PR!
- Added default message to the `bubbleBuilder`. Thanks @asoap for the PR!
- Added `messageWidthRatio` to the chat. Thanks @elihaialgoaitech for the PR!
- Added `customTypingWidget`, `customTypingIndicatorBuilder`, `typingWidgetBuilder` and `multiUserTextBuilder` to the `TypingIndicatorOptions`. Thanks @phamconganh for the PR!

## 1.6.10

- Possibly last release before 2.0.0, which will be a complete re-write focused on extensibility, customizability, performance and stability.
- Fixed repaint if type indicator is not used. Thanks @mozomig for the PR!
- Added ability to highlight message when scrolling to it. Thanks @SergeySor for the PR!
- Added more theming to the text input. Thanks @claudius-kienle for the PR!
- Fixed an exception when user exiting the chat. Thanks @elihaialgoaitech for the PR!
- Fixed input bug for the Japanese language. Thanks @okano4413 for the PR!
- Added `slidableMessageBuilder`. Thanks @leeyisoft for the PR!
- Matchers are now reusable and used in system message as well. Thanks @provokateurin for the PR!
- `avatarBuilder` now provides whole user object. Thanks @kahyoongho for the PR!
- Added semantics for the send button, useful in e2e tests. Thanks @GustekDev for the PR!

## 1.6.9

- Update dependencies

## 1.6.8

- Downgrade `intl` to make it compatible with latest Flutter
- Add `autofocus` to the `InputOptions`. Thanks @josefwilhelm for the PR!

## 1.6.7

- **BREAKING CHANGE**: `nameBuilder` now passes the whole user class, instead of just an id. Thanks @vintage for the PR!
- Add typing indicator. See `typingIndicatorOptions`. Thanks @gtalha07 for the PR! Huge one!
- Add `imageProviderBuilder`. Thanks @marinkobabic for the PR!
- Add `autocorrect` and `enableSuggestions` to the `InputOptions`. By default, both values will be true. Thanks @g0dzillaa for the PR!
- Add `keyboardType` to the `InputOptions`. Thanks @Gramatton for the PR!
- Add Swedish localization. Thanks @OlleEkberg for the PR!
- Add Finnish localization. Thanks @tuoku for the PR!
- Update dependencies. Requires Dart >= 2.19.0.

## 1.6.6

- Add `audioMessageBuilder` (no default implementation yet). Thanks @marinkobabic for the PR!
- Add `videoMessageBuilder` (no default implementation yet).
- Add `SystemMessage` and `systemMessageBuilder`. Thanks @felixgabler for the PR!
- Add `dateIsUtc` to use UTC time for parsing dates inside the chat. Thanks @marinkobabic for the PR!
- Fix unnecessary scrolls to the bottom. Thanks @MaddinMade for the PR!
- Add custom text matchers to the `TextMessageOptions`. Thanks @jld3103 for the PR!
- Add `listBottomWidget`. Thanks @MaddinMade for the PR!
- Fix scroll to unread when no unread messages exist. Thans @jld3103 for the PR!
- Add `useTopSafeAreaInset` to the `Chat` widget, by default enabled on mobile platforms. Use it to disable top safe area inset. Thanks @jld3103 for reporting!
- Fix PatternStyle regexes. Thanks @Mayb3Nots for reporting!
- Update dependencies. Requires Dart >= 2.18.0.

## 1.6.5

- **BREAKING CHANGE**: `PreviewTapOptions` -> `TextMessageOptions`
- **BREAKING CHANGE**: `isTextMessageTextSelectable` -> `TextMessageOptions.isTextSelectable`
- Add unread messages banner and scroll to the first unread. Thanks @felixgabler for the PR!
- Fix every message re-render on new message added. Thanks @otto-dev for the PR!
- Refactor code to make Flyer chat more accessible for contributions. Thanks @felixgabler for the PR!
- Add `imageHeaders`. Allows to pass headers to all images used in the chat. Thanks @marinkobabic for the PR!
- Update to Flutter 3.3.3

## 1.6.4

- **BREAKING CHANGE**: Add `InputOptions`. `onTextChanged`, `onTextFieldTap` and `sendButtonVisibilityMode` are now under `InputOptions` class, just move the same values to `inputOptions: InputOptions()`.
- Add `inputClearMode` to `InputOptions`. Allows you to disable automatic text field clear on submit.
- Add `textEditingController` to `InputOptions`. Allows you to provide a custom editing contoller, but preferably use `InputTextFieldController` we export from the library, if you want to use it to programmatically clear text field or similar.
- Add `keyboardDismissBehavior`.
- Improve image gallery - code optimizations and close button fix. Thanks @felixgabler for the PR!
- Fix input container changing its size. Thanks @joj3000 for the PR!
- Fix enter key not moving text to a new line on web. Thanks @UmairSaqibBhutta for reporting!
- Add `TextMessageOptions`. Thanks @felixgabler for the PR!
- Update dependencies

## 1.6.3

- Added an option to align sent bubbles to the right or left for RTL languages. Thanks @Faaatman for reporting! Use `bubbleRtlAlignment`.
- Add `customStatusBuilder`. Thanks @skllll06 for the PR!

## 1.6.2

- Code refactor
- Update documentation about opening files
- Fixes RTL layout. Thanks @Yahllil for reporting!

## 1.6.1

- Add bold, italic, strikethrough & code style to the input. Thanks @hareshgediya for the PR!
- Add user agent option for preview data fetching. Thanks @felixgabler for the PR!

## 1.6.0

- **BREAKING CHANGE**: `copyWith` on messages works differently (keeping previous values unless set to null), and sometimes casting to a specific message type is required. Please check your codebase if you're using it. Thanks!
- Update to Flutter 3. Thanks @felixgabler for the PR!
- Fix link preview open link. Thanks @felixgabler for the PR!

## 1.5.8

- Fix emoji messages. Thanks @felixgabler for the PR!
- Add loading spinner support for the file message. Thanks @felixgabler for the PR!
- Include safe area insets inside chat itself. No need to wrap in `SafeArea` anymore. Thanks @AdrKacz for reporting!

## 1.5.7

- Add scroller controller as a parameter. Thanks @Faaatman for the PR!
- Make attachment button margin configurable. Thanks @felixgabler for the PR!
- Add `avatarBuilder` and `nameBuilder` methods to resolve user updates and render correct avatars and names. Thanks @dariuspo and @felixgabler for the PR!
- Fix broken text paddings. Thanks @AdrKacz for reporting!
- Update dependencies

## 1.5.6

- Add markdown support. Thanks @felixgabler for the PR!
- Add Arabic localization and RTL support. Thanks @Faaatman for the PR!
- Increase send button tapable area. Thanks @felixgabler for the PR!
- Add new `hidden` send button visibility mode. Thanks @fernandobatels for the PR!
- Add `previewTapOptions` that allow to configure to open link preview when tapped on preview's image or title. Thanks @felixgabler for the PR!
- Add `dateHeaderBuilder`. Thanks @arsamme for the PR!
- Add `onMessageVisibilityChanged` handler. Thanks @felixgabler for the PR!
- Add `receivedMessageBodyBoldTextStyle`, `receivedMessageBodyCodeTextStyle`, `receivedMessageBodyLinkTextStyle` and `sentMessageBodyBoldTextStyle`, `sentMessageBodyCodeTextStyle`, `sentMessageBodyLinkTextStyle` to the theme. Thanks @felixgabler for the PR!
- Add `sendButtonMargin` to the theme. Thanks @damian-kaczmarek for the PR!
- Add German localization. Thanks @felixgabler for the PR!
- Fix emoji only horizontal margin. Thanks @munkius for the PR!
- Update to Flutter 2.10.4. Requires Dart >= 2.16.0.

## 1.5.5

- Fix dark theme. Thanks @garv-shah for the PR!
- Fix keyboard that pushes TextField to the top in mobile browsers. Thanks @jiangyubao for reporting!
- Add `onMessageDoubleTap`. Thanks @leeyisoft for the PR!
- Update dependencies

## 1.5.4

- **BREAKING CHANGE**: Rename `inputPadding` theme key to `inputMargin` (outer insets) and add `inputPadding` (inner insets, previously were hardcoded)
- **BREAKING CHANGE**: Add `BuildContext` as a first parameter for `onMessageLongPress`, `onMessageStatusLongPress`, `onMessageStatusTap`, `onMessageTap`. Thanks @leeyisoft for the PR!
- Add `inputContainerDecoration` to the theme
- Remove keyboard shortuts from Android and iOS platforms. Thanks @kyoungsongKim for reporting!
- Use utf8 codec to parse chinese symbols in link preview. Thanks @minchemo for reporting!
- Update dependencies. Requires Dart >= 2.15.1.

## 1.5.3

- Remove image blur
- Update dependencies

## 1.5.2

- Add status icon tap and long press. Thanks @ikurek for the PR!
- Add Traditional Chinese localization. Thanks @Wei-Hsun for the PR!
- Add `onAvatarTap`
- Fix local image preview on web
- Update dependencies

## 1.5.1

- Increase tests coverage

## 1.5.0

- Remove `Avenir` as a default font family
- Add Simplified Chinese localization. Thanks @roxetter for the PR!
- Enlarge emoji in text messages that consist of emojis. See `emojiEnlargementBehavior` and `hideBackgroundOnEmojiMessages`. Thanks @halildurmus for the PR!
- Add tap on background callback, `onBackgroundTap`. Thanks @diegonuja for the PR!
- Add `ScrollPhysics` to the scroll view. Thanks @trixeenya for the PR!
- Customizable margin for date dividers. See `dateDividerMargin` in theme. Thanks @ikurek for the PR!
- Implemented configurable padding for status icons. See `statusIconPadding` in theme. Thanks @ikurek for the PR!
- Update dependencies (requires Dart >=2.14.0)

## 1.4.4

- Add `dateHeaderThreshold` and `groupMessagesThreshold` (see the documentation comments)
- Update dependencies

## 1.4.3

- Add `bubbleBuilder` to allow the chat bubble customization. See [documentation](https://docs.flyer.chat/flutter/chat-ui/advanced-usage#custom-chat-bubbles).

## 1.4.2

- Add `fileMessageBuilder`, `imageMessageBuilder` and `textMessageBuilder` for more customization options. Thanks @Androrier for the PR!
- Fix avatar initials (show first letters of first and last names, instead of one, where applicable)

## 1.4.1

- Fix release on `pub.dev`

## 1.4.0

- Update to Flutter 2.5

## 1.3.4

- Update dependencies

## 1.3.3

- Add `onTextFieldTap`. Thanks @halildurmus for the PR!
- Add `messageInsetsHorizontal` and `messageInsetsVertical` to the theme to customize message bubble's paddings

## 1.3.2

- Fix memory leak. Thanks @m-j-g for reporting!
- Add `customBottomWidget` useful to remove the input and create a channel view
- Add `inputPadding`, `inputTextCursorColor` and `inputTextDecoration` to the theme for the additional input customization

## 1.3.1

- Rename `buildCustomMessage` to `customMessageBuilder`
- Update dependencies

## 1.3.0

- Chat is now correctly rendered in not full screen mode. Removed `SafeArea` from the lib itself, wrap `Chat` component if needed. Thanks @m-j-g for reporting!
- Fixes crash deserializing `previewData`. Thanks @m-j-g for reporting!
- Fixed automatic scroll to bottom issue in paginated mode. Thanks @m-j-g for reporting!
- Added `userAvatarImageBackgroundColor`. Thanks @pierrebarbaroux for the PR!
- Added `sendButtonVisibilityMode`. Thanks @halildurmus for the PR!
- Added Turkish localization. Thanks @halildurmus for the PR!
- Update dependencies

## 1.2.0

- Fix avatar color when using an image. Thanks @m-j-g for reporting!
- Can't send spaces using keyboard anymore. Thanks @m-j-g for reporting!
- Update dependencies

## 1.1.9

- Add `sendingIcon` widget to the theme. Thanks @abhisunkewar for the PR!
- Update dependencies

## 1.1.8

- Update dependencies and example
- Fix scroll controller not attached warning. Thanks @fikretsengul for reporting the bug!
- Fix right margin on input's progress indicator

## 1.1.7

- Update dependencies

## 1.1.6

- Added `emptyState` that allows you to customize what the user sees when there are no messages. Thanks @AndreHaueisen for the PR!
- Added Korean localization. Thanks @ChangJoo-Park for the PR!
- Can't send spaces anymore. Thanks @kwamerex101 for reporting the bug!

## 1.1.5

- Added `onTextChanged` callback to detect when user is typing. Thanks @AndreHaueisen for the PR!
- Added `dateFormat` and `timeFormat` allowing user to customize the date and time visible between messages. Thanks @AndreHaueisen for the PR!
- Added `customDateHeaderText` allowing to pass and arbitrary string visible between messages. See the documentation in the code for more info.

## 1.1.4

- Remove automatic scroll to bottom for incoming messages

## 1.1.3

- [WEB] Add shortcuts to send messages on `enter` press

## 1.1.2

- The text inside text messages is now selectable. Thanks @AndreHaueisen for the PR!
- Scroll to bottom when new message is added. Thanks @jlubeck for reporting!
- Minor change to make it easier to focus the input field by making the entire composition area tappable. Thanks @muncman for the PR!

## 1.1.1

Export `ChatList` class

## 1.1.0

This release marks a major chat architecture overhaul based on a community feedback. In the future we don't expect such big changes in one release and will try to do backwards compatible code as much as possible.

Breaking changes:

- **BREAKING CHANGE**: [FileMessage] `fileName` is renamed to `name`
- **BREAKING CHANGE**: [ImageMessage] `imageName` is renamed to `name`
- **BREAKING CHANGE**: [Messages] `authorId` is replaced with `author` to support avatars and names inside the chat
- **BREAKING CHANGE**: [Messages] `timestamp` is renamed to `createdAt`. All timestamps are in `ms` now.
- **BREAKING CHANGE**: [Status] `read` is renamed to `seen`
- **BREAKING CHANGE**: [User] `avatarUrl` is renamed to `imageUrl`
- New `custom` and `unsupported` message types. First one is used to build any message you want, second one is to support backwards compatibility

New features:

- Ability to display user name & avatar, `showUserAvatars` and `showUserNames`
- Automatic messages animation
- Pagination, `onEndReached` (use this function to load more items, should be async to correctly show loading indicator), `onEndReachedThreshold` (value between 0 and 1, where 1 indicates that loading should start when all previous items are visible and 0.5 indicates half of items are visible, defaults to 0.75), `isLastPage` (if true loading indicator will not be shown)
- `buildCustomMessage` to build anything you want. Can be improved to modify bubble, PRs are open :)
- Time is moved to headers
- Theme with more customizations

Theme migration guide:

- `attachmentButtonIcon`, `deliveredIcon`, `documentIcon`, `errorIcon`, `seenIcon`, `sendButtonIcon` type change `String` -> `Widget`
- `body1` replaced with `emptyChatPlaceholderTextStyle`, `inputTextStyle`, `receivedMessageBodyTextStyle`, `sentMessageBodyTextStyle`
- `body2` replaced with `receivedMessageLinkDescriptionTextStyle`, `sentMessageLinkDescriptionTextStyle`
- `subtitle1` replaced with `receivedMessageLinkTitleTextStyle`, `sentMessageLinkTitleTextStyle`
- `subtitle2` and `subtitle2Color` are replaced with `dateDividerTextStyle`
- `caption` and `captionColor` are replaced with `receivedMessageCaptionTextStyle`, `sentMessageCaptionTextStyle`
- `primaryTextColor` replaced with `receivedMessageDocumentIconColor`, `sentMessageDocumentIconColor`
- `secondaryTextColor` replaced with `receivedMessageBodyTextStyle`

## 1.0.7

- Disable link preview if `onPreviewDataFetched` is not specified

## 1.0.6

- Update dependencies

## 1.0.5

- Update dependencies

## 1.0.4

- Additional URL preview bug fixes. Thanks @jlubeck for reporting!
- Update to Flutter 2.2

## 1.0.3

- Fix various URL preview bugs (see https://pub.dev/packages/flutter_link_previewer/changelog)
- Add an option to disable URL preview. Thanks @Elementarereigniss for the PR!
- Add Portugese localization. Thanks @BerkSpar for the PR!
- Update dependencies

## 1.0.2

- **BREAKING CHANGE**: `onFilePressed` is replaced with `onMessageTap` to support tap event for different message types. See usage example.
- Added `onMessageLongPress` callback, similar to the `onMessageTap`.
- Added `disableImageGallery` parameter to optionally disable the image gallery on the image tap.
- Added `subtitle2Color` to the theme, which is used to color date dividers in the chat. Thanks @sarbogast for the PR!
- Fixed issues with link preview

## 1.0.1

- Hide the attachment button if `onAttachmentPressed` is not passed

## 1.0.0

- Public release

## 0.8.0

- Update example

## 0.7.0

- Update types

## 0.6.5

- Update dependencies

## 0.6.4

- Add documentation comments

## 0.6.3

- Replace universal IO with conditional import

## 0.6.2

- Update dependencies

## 0.6.1

- Use universal IO

## 0.6.0

- Migrate to Flutter 2

## 0.5.1

- Add gallery

## 0.5.0

- Update types
- Add empty chat placeholder
- Fix images

## 0.4.5

- Add attchment uploading handling

## 0.4.4

- Updated to use partial

## 0.4.3

- Fixed missing null check

## 0.4.2

- Dependency update

## 0.4.1

- Fixed missing null check

## 0.4.0

- Connected with link preview

## 0.3.0

- Remove cached image

## 0.2.0

- Add time and statuses

## 0.1.0

- Update LICENSE

## 0.0.9

- Update types

## 0.0.8

- Update types

## 0.0.7

- Fix image and file name overflow

## 0.0.6

- Add file support

## 0.0.5

- Moved types to the dedicated package

## 0.0.4

- Fix image support

## 0.0.3

- Added image support

## 0.0.2

- Added example

## 0.0.1

- Initial release
