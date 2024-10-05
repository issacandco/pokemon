import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants/app_color.dart';
import '../utils//get_util.dart';

class ImageEnlarger extends StatelessWidget {
  final String imageUrl;
  final String defaultImageUrl;

  const ImageEnlarger({
    super.key,
    required this.imageUrl,
    this.defaultImageUrl = 'assets/images/image_avatar.png',
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          GetUtil.back();
        },
        child: Container(
          color: AppColor.black.withOpacity(0.7),
          child: Center(
            child: Hero(
              tag: 'imageEnlarge',
              child: _buildImageContent(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageContent() {
    if (imageUrl.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.contain,
      );
    } else {
      return Image.asset(defaultImageUrl);
    }
  }
}
