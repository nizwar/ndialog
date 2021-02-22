import 'package:flutter/material.dart';

enum DialogTransitionType {
  Shrink,
  Bubble,
  LeftToRight,
  RightToLeft,
  TopToBottom,
  BottomToTop,
  NONE
}

class DialogTransition {
  static Widget transitionFromLeft(Animation<double> animation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset.zero)
          .animate(animation),
      child: child,
    );
  }

  static Widget transitionFromRight(Animation<double> animation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero)
          .animate(animation),
      child: child,
    );
  }

  static Widget transitionFromTop(Animation<double> animation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset.zero)
          .animate(animation),
      child: child,
    );
  }

  static Widget transitionFromBottom(
      Animation<double> animation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
          .animate(animation),
      child: child,
    );
  }

  static Widget bubble(Animation<double> animation, Widget child) {
    return ScaleTransition(
      scale: CurvedAnimation(
          parent: Tween<double>(begin: 0, end: 1).animate(animation),
          curve: Curves.elasticOut),
      alignment: Alignment.center,
      child: child,
    );
  }

  static Widget shrink(Animation<double> animation, Widget child) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0, end: 1).animate(animation),
      alignment: Alignment.center,
      child: child,
    );
  }
}
