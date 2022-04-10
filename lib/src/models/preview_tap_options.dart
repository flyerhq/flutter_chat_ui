import 'package:meta/meta.dart';

/// Options that allow to open link preview when tapped on image or a title
/// of a preview. By default link preview opens only when tapped on a link itself.
@immutable
class PreviewTapOptions {
  /// Creates preview tap options config
  const PreviewTapOptions({
    this.openOnImageTap = false,
    this.openOnTitleTap = false,
  });

  /// Open link preview when tapped on preview's image
  final bool openOnImageTap;

  /// Open link preview when tapped on preview's title and description
  final bool openOnTitleTap;
}
