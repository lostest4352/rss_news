import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class TitleImage extends StatelessWidget {
  const TitleImage({
    super.key,
    required this.imageLink,
  });

  final String imageLink;

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      imageLink,
      handleLoadingProgress: true,
      loadStateChanged: (state) {
        if (state.extendedImageLoadState == LoadState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.extendedImageLoadState == LoadState.failed) {
          return const Icon(Icons.error);
        } else {
          return ExtendedRawImage(
            image: state.extendedImageInfo?.image,
          );
        }
      },
    );
  }
}
