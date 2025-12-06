import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart' hide Element;
import 'package:flutter_chat_core/flutter_chat_core.dart'
    show LinkPreviewData, ImagePreviewData;
import 'package:html/dom.dart' show Document, Element;
import 'package:html/parser.dart' as parser show parse;
import 'package:http/http.dart' as http show Request, Client, Response;
import 'package:punycode/punycode.dart' as puny;

import 'types.dart';

String _calculateUrl(String baseUrl, String? proxy) {
  var urlToReturn = baseUrl;

  final domainRegex = RegExp(r'^(?:(http|https|ftp):\/\/)?([^\/?#]+)');
  final match = domainRegex.firstMatch(baseUrl);

  if (match != null) {
    final originalDomain = match.group(2)!;

    final labels = originalDomain.split('.');
    if (labels.length <= 10) {
      final encodedLabels = labels.map((label) {
        final isAscii = label.runes.every((r) => r < 128);
        return isAscii ? label : 'xn--${puny.punycodeEncode(label)}';
      }).toList();

      final punycodedDomain = encodedLabels.join('.');
      urlToReturn = baseUrl.replaceFirst(originalDomain, punycodedDomain);
    }
  }

  if (proxy != null) {
    return '$proxy$urlToReturn';
  }

  return urlToReturn;
}

String? _getMetaContent(Document document, String propertyValue) {
  final meta = document.getElementsByTagName('meta');
  final element = meta.firstWhere(
    (e) => e.attributes['property'] == propertyValue,
    orElse: () => meta.firstWhere(
      (e) => e.attributes['name'] == propertyValue,
      orElse: () => Element.tag(null),
    ),
  );

  return element.attributes['content']?.trim();
}

String? _getTitle(Document document) {
  final titleElements = document.getElementsByTagName('title');
  if (titleElements.isNotEmpty) return titleElements.first.text;

  return _getMetaContent(document, 'og:title') ??
      _getMetaContent(document, 'twitter:title') ??
      _getMetaContent(document, 'og:site_name');
}

String? _getDescription(Document document) =>
    _getMetaContent(document, 'og:description') ??
    _getMetaContent(document, 'description') ??
    _getMetaContent(document, 'twitter:description');

List<String> _getImageUrls(Document document, String baseUrl) {
  final meta = document.getElementsByTagName('meta');
  var attribute = 'content';
  var elements = meta
      .where(
        (e) =>
            e.attributes['property'] == 'og:image' ||
            e.attributes['property'] == 'twitter:image',
      )
      .toList();

  if (elements.isEmpty) {
    elements = document.getElementsByTagName('img');
    attribute = 'src';
  }

  return elements.fold<List<String>>([], (previousValue, element) {
    final actualImageUrl = _getActualImageUrl(
      baseUrl,
      element.attributes[attribute]?.trim(),
    );

    return actualImageUrl != null
        ? [...previousValue, actualImageUrl]
        : previousValue;
  });
}

String? _getActualImageUrl(String baseUrl, String? imageUrl) {
  if (imageUrl == null || imageUrl.isEmpty || imageUrl.startsWith('data')) {
    return null;
  }

  if (imageUrl.contains('.svg') || imageUrl.contains('.gif')) return null;

  if (imageUrl.startsWith('//')) imageUrl = 'https:$imageUrl';

  if (!imageUrl.startsWith('http')) {
    if (baseUrl.endsWith('/') && imageUrl.startsWith('/')) {
      imageUrl = '${baseUrl.substring(0, baseUrl.length - 1)}$imageUrl';
    } else if (!baseUrl.endsWith('/') && !imageUrl.startsWith('/')) {
      imageUrl = '$baseUrl/$imageUrl';
    } else {
      imageUrl = '$baseUrl$imageUrl';
    }
  }

  return imageUrl;
}

Future<Size> _getImageSize(String url) {
  final completer = Completer<Size>();
  final stream = Image.network(url).image.resolve(ImageConfiguration.empty);
  late ImageStreamListener streamListener;

  void onError(Object error, StackTrace? stackTrace) {
    completer.completeError(error, stackTrace);
  }

  void listener(ImageInfo info, bool _) {
    if (!completer.isCompleted) {
      completer.complete(
        Size(
          height: info.image.height.toDouble(),
          width: info.image.width.toDouble(),
        ),
      );
    }
    stream.removeListener(streamListener);
  }

  streamListener = ImageStreamListener(listener, onError: onError);

  stream.addListener(streamListener);
  return completer.future;
}

Future<Size> _getImageSizeFromBytes(Uint8List bytes) async {
  final image = await decodeImageFromList(bytes);
  return Size(height: image.height.toDouble(), width: image.width.toDouble());
}

Future<String> _getBiggestImageUrl(
  List<String> imageUrls,
  String? proxy,
) async {
  if (imageUrls.length > 5) {
    imageUrls.removeRange(5, imageUrls.length);
  }

  var currentUrl = imageUrls[0];
  var currentArea = 0.0;

  await Future.forEach(imageUrls, (String url) async {
    final size = await _getImageSize(_calculateUrl(url, proxy));
    final area = size.width * size.height;
    if (area > currentArea) {
      currentArea = area;
      currentUrl = _calculateUrl(url, proxy);
    }
  });

  return currentUrl;
}

Future<http.Response?> _getRedirectedResponse(
  Uri uri, {
  Map<String, String>? headers,
  int maxRedirects = 5,
  Duration timeout = const Duration(seconds: 5),
  http.Client? client,
}) async {
  final httpClient = client ?? http.Client();
  var redirectCount = 0;

  while (redirectCount < maxRedirects) {
    final request = http.Request('GET', uri)..followRedirects = false;

    if (headers != null) {
      request.headers.addAll(headers);
    }

    final streamedResponse = await httpClient.send(request).timeout(timeout);

    if (streamedResponse.isRedirect &&
        streamedResponse.headers.containsKey('location')) {
      uri = uri.resolve(streamedResponse.headers['location']!);
      redirectCount++;
      continue;
    }

    return http.Response.fromStream(streamedResponse);
  }

  return null;
}

/// Parses provided text and returns [PreviewData] for the first found link.
Future<LinkPreviewData?> getLinkPreviewData(
  String text, {
  Map<String, String>? headers,
  String? proxy,
  Duration? requestTimeout,
  String? userAgent,
}) async {
  String? previewDataDescription;
  String? previewDataTitle;
  String? previewDataUrl;
  ImagePreviewData? previewDataImage;
  Size imageSize;
  String previewDataImageUrl;

  try {
    final emailRegexp = RegExp(regexEmail, caseSensitive: false);
    final textWithoutEmails = text
        .replaceAllMapped(emailRegexp, (match) => '')
        .trim();
    if (textWithoutEmails.isEmpty) return null;

    final urlRegexp = RegExp(regexLink, caseSensitive: false, unicode: true);
    final matches = urlRegexp.allMatches(textWithoutEmails);
    if (matches.isEmpty) return null;

    var url = textWithoutEmails.substring(
      matches.first.start,
      matches.first.end,
    );

    if (!url.toLowerCase().startsWith('http')) {
      url = 'https://$url';
    }
    previewDataUrl = _calculateUrl(url, proxy);
    final uri = Uri.parse(previewDataUrl);

    final defaultHeaders = kIsWeb
        ? {
            'Access-Control-Allow-Origin': '*',
            'Content-Type': 'application/json',
            'Accept': '*/*',
          }
        : {};

    final effectiveHeaders = <String, String>{
      ...defaultHeaders,
      'User-Agent': userAgent ?? 'WhatsApp/2',
      ...?headers,
    };

    final response = await _getRedirectedResponse(
      uri,
      headers: effectiveHeaders,
      timeout: requestTimeout ?? const Duration(seconds: 5),
    );

    if (response == null || response.statusCode != 200) {
      return null;
    }
    url = response.request?.url.toString() ?? url;

    final imageRegexp = RegExp(regexImageContentType);

    if (imageRegexp.hasMatch(response.headers['content-type'] ?? '')) {
      final imageSize = await _getImageSizeFromBytes(response.bodyBytes);
      return LinkPreviewData(
        link: previewDataUrl,
        image: ImagePreviewData(
          url: previewDataUrl,
          height: imageSize.height,
          width: imageSize.width,
        ),
      );
    }

    Document document;
    try {
      Encoding encoding;
      final contentType = response.headers['content-type']?.toLowerCase() ?? '';
      if (contentType.contains('charset=')) {
        final charset = contentType.split('charset=')[1].split(';')[0].trim();
        encoding = Encoding.getByName(charset) ?? utf8;
        debugPrint('encoding: $encoding');
      } else {
        encoding = utf8;
      }

      document = parser.parse(encoding.decode(response.bodyBytes));
    } catch (e) {
      // Always return the url so it's displayed and clickable
      return LinkPreviewData(link: previewDataUrl, title: previewDataTitle);
    }

    final title = _getTitle(document);
    if (title != null) {
      previewDataTitle = title.trim();
    }

    final description = _getDescription(document);
    if (description != null) {
      previewDataDescription = description.trim();
    }

    try {
      final imageUrls = _getImageUrls(document, url);

      if (imageUrls.isNotEmpty) {
        previewDataImageUrl = imageUrls.length == 1
            ? _calculateUrl(imageUrls[0], proxy)
            : await _getBiggestImageUrl(imageUrls, proxy);

        imageSize = await _getImageSize(previewDataImageUrl);
        previewDataImage = ImagePreviewData(
          url: previewDataImageUrl,
          width: imageSize.width,
          height: imageSize.height,
        );
      }
    } catch (_) {}
    return LinkPreviewData(
      link: previewDataUrl,
      title: previewDataTitle,
      description: previewDataDescription,
      image: previewDataImage,
    );
  } catch (e) {
    return null;
  }
}

/// Regex to check if text is email.
const regexEmail = r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}';

/// Regex to check if content type is an image.
const regexImageContentType = r'image\/*';

/// Regex to find all links in the text.
const regexLink =
    r'((http|ftp|https):\/\/)?(([\p{L}\p{N}_-]+)(?:(?:\.([\p{L}\p{N}_-]*[\p{L}_][\p{L}\p{N}_-]*))+))([\p{L}\p{N}.,@?^=%&:/~+#-]*[\p{L}\p{N}@?^=%&/~+#-])?[^\.\s]';
