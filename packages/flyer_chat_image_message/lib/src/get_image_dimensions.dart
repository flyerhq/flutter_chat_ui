import 'dart:async';
import 'package:flutter/widgets.dart';

typedef Dimensions = (double width, double height);

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
