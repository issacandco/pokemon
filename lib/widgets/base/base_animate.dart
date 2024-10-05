import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

enum AnimationType {
  fadeIn,
  fadeInDown,
  fadeInUp,
  fadeOut,
  fadeOutUp,
  fadeOutDown,
  bounceInUp,
  bounceInDown,
  bounceInLeft,
  bounceInRight,
  slideInUp,
  slideInDown,
  slideInLeft,
  slideInRight,
  zoomIn,
  zoomOut,
  flipInX,
  flipInY,
}

class BaseAnimate extends StatelessWidget {
  final AnimationType animationType;
  final int delay;
  final int duration;
  final Widget child;

  const BaseAnimate({
    super.key,
    required this.animationType,
    this.delay = 500,
    this.duration = 1000,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Duration delayDuration = Duration(milliseconds: delay);
    Duration animationDuration = Duration(milliseconds: duration);

    return _buildAnimation(animationType, delayDuration, animationDuration, child);
  }

  Widget _buildAnimation(AnimationType type, Duration delay, Duration duration, Widget child) {
    switch (type) {
      case AnimationType.fadeIn:
        return FadeIn(delay: delay, duration: duration, child: child);
      case AnimationType.fadeInDown:
        return FadeInDown(delay: delay, duration: duration, child: child);
      case AnimationType.fadeInUp:
        return FadeInUp(delay: delay, duration: duration, child: child);
      case AnimationType.fadeOut:
        return FadeOut(delay: delay, duration: duration, child: child);
      case AnimationType.fadeOutUp:
        return FadeOutUp(delay: delay, duration: duration, child: child);
      case AnimationType.fadeOutDown:
        return FadeOutDown(delay: delay, duration: duration, child: child);
      case AnimationType.bounceInUp:
        return BounceInUp(delay: delay, duration: duration, child: child);
      case AnimationType.bounceInDown:
        return BounceInDown(delay: delay, duration: duration, child: child);
      case AnimationType.bounceInLeft:
        return BounceInLeft(delay: delay, duration: duration, child: child);
      case AnimationType.bounceInRight:
        return BounceInRight(delay: delay, duration: duration, child: child);
      case AnimationType.slideInUp:
        return SlideInUp(delay: delay, duration: duration, child: child);
      case AnimationType.slideInDown:
        return SlideInDown(delay: delay, duration: duration, child: child);
      case AnimationType.slideInLeft:
        return SlideInLeft(delay: delay, duration: duration, child: child);
      case AnimationType.slideInRight:
        return SlideInRight(delay: delay, duration: duration, child: child);
      case AnimationType.zoomIn:
        return ZoomIn(delay: delay, duration: duration, child: child);
      case AnimationType.zoomOut:
        return ZoomOut(delay: delay, duration: duration, child: child);
      case AnimationType.flipInX:
        return FlipInX(delay: delay, duration: duration, child: child);
      case AnimationType.flipInY:
        return FlipInY(delay: delay, duration: duration, child: child);
      default:
        return child;
    }
  }
}
