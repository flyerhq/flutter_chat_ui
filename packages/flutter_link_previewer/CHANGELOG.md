## 4.2.0

 - **FEAT**: update deps - requires min dart 3.8 and flutter 3.32 ([#871](https://github.com/flyerhq/flutter_chat_ui/issues/871)). ([588b34bd](https://github.com/flyerhq/flutter_chat_ui/commit/588b34bd398900c8f25ee69c574d1e35391af1d1))

## 4.1.2

 - Update a dependency to the latest release.

## 4.1.1

 - **FIX**: update LICENSE. ([209a1292](https://github.com/flyerhq/flutter_chat_ui/commit/209a129297ebe7fd202e41273c9c0ddd52b8b983))
 - **FIX**: add example to the flutter_link_previewer. ([a307c9e9](https://github.com/flyerhq/flutter_chat_ui/commit/a307c9e9394a077fb87106c192c55c029ace17fd))

## 4.1.0

 - **FEAT**: support international domains. ([9626bc29](https://github.com/flyerhq/flutter_chat_ui/commit/9626bc292dd6254b155176994401271d86b23a53))

## 4.0.0

- **BREAKING CHANGE**: The **LinkPreview** widget has been completely rewritten for improved clarity and modern design.

  - **Separation of Concerns**: The widget no longer manages or highlights links within parent text. It is now focused solely on rendering the link preview itself. This resolves previous design choices where the preview was coupled with unrelated text logic.
  - **Modernized Default Style**: The default appearance has been updated to better match modern messenger apps, while retaining full customizability through parameters.
  - **Parameter Renames**: To improve clarity and consistency, some parameters have been renamed:
    - `onPreviewDataFetched` → `onLinkPreviewDataFetched`
    - `previewData` → `linkPreviewData`
  - **API Changes**: Most other parameters and internals have changed as part of the rewrite. Please review the updated source code to see the new customization options.

## 3.2.2

- Update dependencies

## 3.2.1

- Add `previewBuilder` to allow you to create your own implementation of a link preview. Thanks @CatEatFishs for suggestion!
- Fix numbers being parsed as urls. Thanks @claptv for noticing!
- Update dependencies. Requires Dart >= 2.19.0.

## 3.2.0

- Update dependencies. Requires Dart >= 2.18.0.

## 3.1.0

- Update to Flutter 3.3.3
- Set `WhatsApp/2` as a default user agent to parse more links
- Added `requestTimeout` parameter, that will cancel the request if timeout is reached. Defaults to 5 seconds.

## 3.0.1

- Code refactor

## 3.0.0

- Update to Flutter 3
- Add `userAgent` parameter. Thanks @felixgabler for the PR!

## 2.6.6

- Update dependencies

## 2.6.5

- Update dependencies

## 2.6.4

- Update to Flutter 2.10.4

## 2.6.3

- Fixed `looking up deactivated ancestor is unsafe` error. Thanks @felixgabler for the PR!
- Add `openOnPreviewImageTap` and `openOnPreviewTitleTap` - allows to open link URL when tapped on the preview image and/or preview title/description. Thanks @felixgabler for the PR!
- Update to Flutter 2.10.2. Requires Dart >= 2.16.0.

## 2.6.2

- Use utf8 codec to parse chinese symbols
- Update dependencies. Requires Dart >= 2.15.1.

## 2.6.1

- Update dependencies

## 2.6.0

- Updated dependencies (requires Dart >=2.14.0)
- Fixed Android example. Thanks @rvndsngwn for reporting!

## 2.5.2

Additionally, revert `json_annotation` upgrade

## 2.5.1

Revert `meta` upgrade, because `pub.dev` is analyzing code with an old Flutter version

## 2.5.0

- Update to Flutter 2.5
- Rename `REGEX_EMAIL` to `regexEmail` and `REGEX_LINK` to `regexLink`

## 2.4.2

- Update dependencies

## 2.4.1

- Update dependencies

## 2.4.0

- Update dependencies

## 2.3.0

- Improve REGEX
- Add custom `imageBuilder`

## 2.2.3

- Update dependencies

## 2.2.2

- Fix completer that never completes and add `corsProxy` parameter. Thanks @wer-mathurin for the PR!
- Export `getPreviewData` to allow you to create your own implementation of a link preview.

## 2.2.1

- Update dependencies

## 2.2.0

- Add `hideImage` param

## 2.1.0

- Update dependencies

## 2.0.8

- Update dependencies

## 2.0.7

- Fix alignment

## 2.0.6

- Update to Flutter 2.2

## 2.0.5

- Fix links starting from a capital `Http`

## 2.0.4

- Add preview for the image link

## 2.0.3

- Add a custom header above the text

## 2.0.2

- Fix paddings for an empty preview data
- Limit number of images parsed
- Fix regex

## 2.0.1

- Fix custom padding and add a custom link press handler

## 2.0.0

- **BREAKING**: `onPreviewDataFetched` and `previewData` are now required. In the previous version, a link preview used on a ListView resulted in a fetch call every time the preview was appearing on a screen.

## 1.0.6

- Fix warnings and layout issues

## 1.0.5

- Add an optional animation

## 1.0.4

- Update dependencies

## 1.0.3

- Update dependencies

## 1.0.2

- Update dependencies

## 1.0.1

- Add CI

## 1.0.0

- Add documentation

## 0.2.2

- Update to null safety

## 0.2.1

- Code cleanup

## 0.2.0

- Flutter 2 update

## 0.1.0

- Dependency update

## 0.0.9

- Readme added

## 0.0.8

- Dependency update

## 0.0.7

- Use types from utility library

## 0.0.6

- Make widget stateless

## 0.0.5

- Render plain text on loading and error

## 0.0.4

- Critical fix and remove unneeded code

## 0.0.3

- Code improvements and cleanup

## 0.0.2

- Added customization

## 0.0.1

- Initial release
