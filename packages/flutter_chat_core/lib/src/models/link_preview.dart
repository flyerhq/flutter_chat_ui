import 'package:freezed_annotation/freezed_annotation.dart';

part 'link_preview.freezed.dart';
part 'link_preview.g.dart';

/// Represents the data extracted for a link preview.
@freezed
abstract class LinkPreview with _$LinkPreview {
  /// Creates a [LinkPreview] instance.
  const factory LinkPreview({
    /// The original URL link.
    required String link,

    /// A description extracted from the link source.
    String? description,

    /// The URL of an image associated with the link.
    String? imageUrl,

    /// The title extracted from the link source.
    String? title,
  }) = _LinkPreview;

  const LinkPreview._();

  /// Creates a [LinkPreview] instance from a JSON map.
  factory LinkPreview.fromJson(Map<String, dynamic> json) =>
      _$LinkPreviewFromJson(json);
}
