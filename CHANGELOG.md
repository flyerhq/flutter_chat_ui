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
- Add portugese localization. Thanks @BerkSpar for the PR!
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
