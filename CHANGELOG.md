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
