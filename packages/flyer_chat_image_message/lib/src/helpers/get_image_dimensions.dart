import 'dart:async';
import 'package:flutter/widgets.dart';

/// Represents the width and height dimensions of an image.
typedef Dimensions = (double width, double height);

/// Asynchronously retrieves the dimensions (width and height) of an image
/// provided by an [ImageProvider].
///
/// Uses an [ImageStreamListener] to get the image details once resolved.
///
/// Returns a [Future] that completes with a [Dimensions] record, or completes
/// with an error if the image cannot be resolved or its dimensions determined.
Future<Dimensions> getImageDimensions(ImageProvider provider) {
  final completer = Completer<Dimensions>();
  const config = ImageConfiguration.empty;

  provider
      .obtainKey(config)
      .then((key) {
        final stream = provider.resolve(config);

        final listener = ImageStreamListener(
          (image, synchronousCall) {
            completer.complete((
              image.image.width.toDouble(),
              image.image.height.toDouble(),
            ));
          },
          onError: (exception, stackTrace) {
            completer.completeError(exception, stackTrace);
          },
        );

        stream.addListener(listener);

        completer.future.whenComplete(() {
          stream.removeListener(listener);
        });
      })
      .catchError((error) {
        completer.completeError(error);
      });

  return completer.future;
}
