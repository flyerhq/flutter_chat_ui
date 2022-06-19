import 'package:flutter/material.dart';

import 'conditional_stub.dart'
    if (dart.library.io) 'io_conditional.dart'
    if (dart.library.html) 'browser_conditional.dart';

/// The abstract class for a conditional import feature.
abstract class Conditional {
  /// Creates a new platform appropriate conditional.
  ///
  /// Creates an `IOConditional` if `dart:io` is available and a `BrowserConditional` if
  /// `dart:html` is available, otherwise it will throw an unsupported error.
  factory Conditional() => createConditional();

  /// Returns an appropriate platform ImageProvider for specified URI.
  ImageProvider getProvider(String uri);
}
