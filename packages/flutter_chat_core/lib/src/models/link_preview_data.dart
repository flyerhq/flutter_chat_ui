import 'package:freezed_annotation/freezed_annotation.dart';

part 'link_preview_data.freezed.dart';
part 'link_preview_data.g.dart';

/// Represents the data extracted for a link preview.
@freezed
abstract class LinkPreviewData with _$LinkPreviewData {
  /// Creates a [LinkPreviewData] instance.
  const factory LinkPreviewData({
    /// The original URL link.
    required String link,

    /// A description extracted from the link source.
    String? description,

    /// The URL of an image associated with the link.
    String? imageUrl,

    /// The image width.
    int? imageWidth,

    /// The image height.
    int? imageHeight,

    /// The title extracted from the link source.
    String? title,

  }) = _LinkPreviewData;

  const LinkPreviewData._();

  /// Creates a [LinkPreviewData] instance from a JSON map.
  factory LinkPreviewData.fromJson(Map<String, dynamic> json) =>
      _$LinkPreviewDataFromJson(json);
}
