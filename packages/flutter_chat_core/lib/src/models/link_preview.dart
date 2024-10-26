import 'package:freezed_annotation/freezed_annotation.dart';

part 'link_preview.freezed.dart';
part 'link_preview.g.dart';

@Freezed()
class LinkPreview with _$LinkPreview {
  const factory LinkPreview({
    required String link,
    String? description,
    String? imageUrl,
    String? title,
  }) = _LinkPreview;

  factory LinkPreview.fromJson(Map<String, dynamic> json) =>
      _$LinkPreviewFromJson(json);
}
