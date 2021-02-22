import 'package:flutter/material.dart';
import 'package:ndialog/src/transition.dart';

class DialogUtils {
  final bool dismissable;
  final Widget child;
  final DialogTransitionType dialogTransitionType;
  final Color barrierColor;
  final RouteSettings routeSettings;
  final bool useRootNavigator;
  final bool useSafeArea;
  final Duration transitionDuration;

  DialogUtils({
    this.useSafeArea,
    this.barrierColor,
    this.dismissable,
    this.child,
    this.dialogTransitionType,
    this.routeSettings,
    this.transitionDuration,
    this.useRootNavigator,
  });

  ///Show dialog directly
  Future show<T>(BuildContext context) => showGeneralDialog<T>(
        context: context,
        pageBuilder: (context, animation, secondaryAnimation) =>
            (useSafeArea ?? false) ? SafeArea(child: child) : child,
        barrierColor: barrierColor ?? Color(0x00ffffff),
        barrierDismissible: dismissable ?? true,
        barrierLabel: "",
        transitionDuration: transitionDuration ?? Duration(milliseconds: 500),
        transitionBuilder: (context, animation, secondaryAnimation, child) =>
            _animationWidget(animation, child),
        useRootNavigator: useRootNavigator ?? false,
      );

  Widget _animationWidget(Animation<double> animation, Widget child) {
    switch (dialogTransitionType ?? DialogTransitionType.NONE) {
      case DialogTransitionType.Bubble:
        return DialogTransition.bubble(animation, child);
        break;
      case DialogTransitionType.LeftToRight:
        return DialogTransition.transitionFromLeft(animation, child);
        break;
      case DialogTransitionType.RightToLeft:
        return DialogTransition.transitionFromRight(animation, child);
        break;
      case DialogTransitionType.TopToBottom:
        return DialogTransition.transitionFromTop(animation, child);
        break;
      case DialogTransitionType.BottomToTop:
        return DialogTransition.transitionFromBottom(animation, child);
        break;
      case DialogTransitionType.Shrink:
        return DialogTransition.shrink(animation, child);
        break;
      default:
    }
    return child;
  }
}
