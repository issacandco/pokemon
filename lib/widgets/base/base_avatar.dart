import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants/app_size.dart';
import 'base_shimmer.dart';

class BaseAvatar extends StatelessWidget {
  const BaseAvatar({
    super.key,
    this.url,
    this.errorPlaceHolder,
    this.placeholder,
    this.size,
    this.defaultImageUrl = 'assets/images/image_avatar.png',
    this.attachmentImageUrl,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
  });

  final String? url;
  final Widget? errorPlaceHolder;
  final Widget? placeholder;
  final double? size;
  final String defaultImageUrl;
  final String? attachmentImageUrl;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    final double avatarSize = size ?? AppSize.getSize(48);
    final BorderRadius avatarBorderRadius = borderRadius ?? BorderRadius.circular(avatarSize);

    return ClipRRect(
      borderRadius: avatarBorderRadius,
      child: Container(
        width: avatarSize,
        height: avatarSize,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.grey[200],
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 0,
          ),
          borderRadius: avatarBorderRadius,
        ),
        child: _buildAvatarContent(context, avatarSize),
      ),
    );
  }

  Widget _buildAvatarContent(BuildContext context, double avatarSize) {
    if (attachmentImageUrl != null) {
      return Image.file(
        File(attachmentImageUrl!),
        width: avatarSize,
        height: avatarSize,
        fit: BoxFit.cover,
      );
    }

    return url != null && url!.startsWith('http')
        ? CachedNetworkImage(
            imageUrl: url!,
            placeholder: (context, url) => _buildDefaultPlaceholder(avatarSize),
            errorWidget: (context, url, error) => errorPlaceHolder ?? const Icon(Icons.error),
            imageBuilder: (context, imageProvider) => Image(
              image: imageProvider,
              width: avatarSize,
              height: avatarSize,
              fit: BoxFit.cover,
            ),
          )
        : Image.asset(
            defaultImageUrl,
            width: avatarSize,
            height: avatarSize,
            fit: BoxFit.cover,
          );
  }

  Widget _buildDefaultPlaceholder(double avatarSize) {
    return SizedBox(
      width: avatarSize,
      height: avatarSize,
      child: placeholder ??
          BaseShimmer.circular(
            width: avatarSize,
            height: avatarSize,
          ),
    );
  }
}
