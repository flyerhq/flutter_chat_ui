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

    /// The preview data of an image extracted from the link
    ImagePreviewData? image,

    /// The title extracted from the link source.
    String? title,
  }) = _LinkPreviewData;

  const LinkPreviewData._();

  /// Creates a [LinkPreviewData] instance from a JSON map.
  factory LinkPreviewData.fromJson(Map<String, dynamic> json) =>
      _$LinkPreviewDataFromJson(json);
}

/// Represents the data extracted for a link preview image.
@freezed
abstract class ImagePreviewData with _$ImagePreviewData {
  /// Creates a [ImagePreviewData] instance.
  const factory ImagePreviewData({
    /// The URL of an image associated with the link.
    required String url,

    /// The image width.
    required double width,

    /// The image height.
    required double height,
  }) = _ImagePreviewData;

  const ImagePreviewData._();

  /// Creates a [ImagePreviewData] instance from a JSON map.
  factory ImagePreviewData.fromJson(Map<String, dynamic> json) =>
      _$ImagePreviewDataFromJson(json);
}
