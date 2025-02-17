import 'package:flutter/material.dart';
import 'package:ndialog/src/transition.dart';

Color get generalBarrierColor => Colors.black.withValues(alpha: .5);

class DialogUtils {
  final bool? dismissable;
  final Widget? child;
  final DialogTransitionType? dialogTransitionType;
  final Color? barrierColor;
  final RouteSettings? routeSettings;
  final bool? useRootNavigator;
  final bool? useSafeArea;

  ///Set it null to start the animation with default duration
  final Duration? transitionDuration;

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
  Future<T?> show<T>(BuildContext context) {
    Duration defaultDuration = Duration(seconds: 1);
    switch (dialogTransitionType ?? DialogTransitionType.NONE) {
      case DialogTransitionType.Bubble:
        defaultDuration = Duration(milliseconds: 500);
        break;
      case DialogTransitionType.LeftToRight:
        defaultDuration = Duration(milliseconds: 230);
        break;
      case DialogTransitionType.RightToLeft:
        defaultDuration = Duration(milliseconds: 230);
        break;
      case DialogTransitionType.TopToBottom:
        defaultDuration = Duration(milliseconds: 300);
        break;
      case DialogTransitionType.BottomToTop:
        defaultDuration = Duration(milliseconds: 300);
        break;
      case DialogTransitionType.Shrink:
        defaultDuration = Duration(milliseconds: 200);
        break;
      default:
        defaultDuration = Duration.zero;
    }
    return showGeneralDialog<T>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          (useSafeArea ?? false)
              ? SafeArea(child: child ?? SizedBox.shrink())
              : (child ?? SizedBox.shrink()),
      barrierColor: barrierColor ?? generalBarrierColor,
      barrierDismissible: dismissable ?? true,
      barrierLabel: "",
      transitionDuration: transitionDuration ?? defaultDuration,
      transitionBuilder: (context, animation, secondaryAnimation, child) =>
          _animationWidget(animation, child),
      useRootNavigator: useRootNavigator ?? false,
    );
  }

  Widget _animationWidget(Animation<double> animation, Widget child) {
    switch (dialogTransitionType ?? DialogTransitionType.NONE) {
      case DialogTransitionType.Bubble:
        return DialogTransition.bubble(animation, child);
      case DialogTransitionType.LeftToRight:
        return DialogTransition.transitionFromLeft(animation, child);
      case DialogTransitionType.RightToLeft:
        return DialogTransition.transitionFromRight(animation, child);
      case DialogTransitionType.TopToBottom:
        return DialogTransition.transitionFromTop(animation, child);
      case DialogTransitionType.BottomToTop:
        return DialogTransition.transitionFromBottom(animation, child);
      case DialogTransitionType.Shrink:
        return DialogTransition.shrink(animation, child);
      default:
    }
    return child;
  }
}
