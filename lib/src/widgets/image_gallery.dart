import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../conditional/conditional.dart';
import '../models/preview_image.dart';

class ImageGallery extends StatelessWidget {
  const ImageGallery({
    super.key,
    required this.images,
    required this.pageController,
    required this.onClosePressed,
  });

  final List<PreviewImage> images;
  final PageController pageController;
  final VoidCallback onClosePressed;

  @override
  Widget build(BuildContext context) => Dismissible(
        key: const Key('photo_view_gallery'),
        direction: DismissDirection.down,
        onDismissed: (direction) => onClosePressed(),
        child: Stack(
          children: [
            PhotoViewGallery.builder(
              builder: (BuildContext context, int index) =>
                  PhotoViewGalleryPageOptions(
                imageProvider: Conditional().getProvider(images[index].uri),
              ),
              itemCount: images.length,
              loadingBuilder: (context, event) =>
                  _imageGalleryLoadingBuilder(event),
              onPageChanged: (_) {},
              pageController: pageController,
              scrollPhysics: const ClampingScrollPhysics(),
            ),
            Positioned.directional(
              end: 16,
              textDirection: Directionality.of(context),
              top: 56,
              child: CloseButton(
                color: Colors.white,
                onPressed: onClosePressed,
              ),
            ),
          ],
        ),
      );

  Widget _imageGalleryLoadingBuilder(ImageChunkEvent? event) => Center(
    child: SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        value: event == null || event.expectedTotalBytes == null
            ? 0
            : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
      ),
    ),
  );
}
