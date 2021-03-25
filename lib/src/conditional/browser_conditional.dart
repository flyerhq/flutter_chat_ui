import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'base_conditional.dart';

/// Create a [BrowserConditional].
///
/// Used from conditional imports, matches the definition in `conditional_stub.dart`.
BaseConditional createConditional() => BrowserConditional();

/// A conditional for browser
class BrowserConditional extends BaseConditional {
  /// Returns [NetworkImage] if URI starts with http
  /// otherwise returns transparent image
  @override
  ImageProvider getProvider(String uri) {
    if (uri.startsWith('http') || uri.startsWith('blob')) {
      return NetworkImage(uri);
    } else {
      return MemoryImage(kTransparentImage);
    }
  }
}

/// Transparent image data
final kTransparentImage = Uint8List.fromList(
  <int>[
    0x89,
    0x50,
    0x4E,
    0x47,
    0x0D,
    0x0A,
    0x1A,
    0x0A,
    0x00,
    0x00,
    0x00,
    0x0D,
    0x49,
    0x48,
    0x44,
    0x52,
    0x00,
    0x00,
    0x00,
    0x01,
    0x00,
    0x00,
    0x00,
    0x01,
    0x08,
    0x06,
    0x00,
    0x00,
    0x00,
    0x1F,
    0x15,
    0xC4,
    0x89,
    0x00,
    0x00,
    0x00,
    0x0A,
    0x49,
    0x44,
    0x41,
    0x54,
    0x78,
    0x9C,
    0x63,
    0x00,
    0x01,
    0x00,
    0x00,
    0x05,
    0x00,
    0x01,
    0x0D,
    0x0A,
    0x2D,
    0xB4,
    0x00,
    0x00,
    0x00,
    0x00,
    0x49,
    0x45,
    0x4E,
    0x44,
    0xAE,
  ],
);
