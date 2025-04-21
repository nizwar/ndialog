import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

///Extension of Dialog
extension DialogShow on Dialog {
  Future<T?> show<T>(
    BuildContext context, {
    bool barrierDismissible = true,
    Color? barrierColor,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
  }) =>
      showDialog<T>(
        context: context,
        builder: (context) => this,
        barrierDismissible: barrierDismissible,
        barrierColor: barrierColor,
        useSafeArea: useSafeArea,
        useRootNavigator: useRootNavigator,
        routeSettings: routeSettings,
      );
}

///Extension of AlertDialog
extension AlertDialogShow on AlertDialog {
  Future<T?> show<T>(
    BuildContext context, {
    bool barrierDismissible = true,
    Color? barrierColor,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    DialogTransitionType? dialogTransitionType,
  }) =>
      DialogUtils(
        barrierColor: barrierColor ?? generalBarrierColor,
        child: this,
        dismissable: barrierDismissible,
        dialogTransitionType: dialogTransitionType,
        routeSettings: routeSettings,
        useRootNavigator: useRootNavigator,
        useSafeArea: useSafeArea,
      ).show(context);
}

///Extension of SimpleDialog
extension SimpleDialogShow on SimpleDialog {
  Future<T?> show<T>(
    BuildContext context, {
    bool? barrierDismissible = true,
    Color? barrierColor,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    DialogTransitionType? dialogTransitionType,
  }) =>
      DialogUtils(
        barrierColor: barrierColor ?? generalBarrierColor,
        child: this,
        dismissable: barrierDismissible,
        dialogTransitionType: dialogTransitionType,
        routeSettings: routeSettings,
        useRootNavigator: useRootNavigator,
        useSafeArea: useSafeArea,
      ).show<T?>(context);
}

///Extension of CupertinoAlertDialog
extension CupertinoAlertDialogShow on CupertinoAlertDialog {
  Future<T?> show<T>(
    BuildContext context, {
    bool barrierDismissible = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
  }) =>
      showCupertinoDialog<T>(
        context: context,
        builder: (context) => this,
        barrierDismissible: barrierDismissible,
        useRootNavigator: useRootNavigator,
        routeSettings: routeSettings,
      );
}

extension FutureDialog<T> on Future<T> {
  Future<T?> showProgressDialog(
    BuildContext context, {
    double? blur,
    Color? backgroundColor,
    DialogTransitionType? dialogTransitionType,
    bool? dismissable,
    Duration? transitionDuration,
    @Deprecated("Use try catch or .catchError instead") OnProgressError? onProgressError,
    @Deprecated("Use .then instead") OnProgressFinish? onProgressFinish,
    @Deprecated("Use .then instead") OnProgressCancel? onProgressCancel,
    Function? onDismiss,
    Widget Function(Function onDismiss)? cancelButtonWidget,
    @required Widget? message,
    @required Widget? title,
    Widget? progressWidget,
    DialogStyle? dialogStyle,
  }) =>
      ProgressDialog.future<T?>(
        context,
        future: this,
        blur: blur,
        dialogStyle: dialogStyle,
        message: message,
        title: title,
        progressWidget: progressWidget,
        backgroundColor: backgroundColor,
        dialogTransitionType: dialogTransitionType,
        dismissable: dismissable,
        cancelButton: cancelButtonWidget,
        transitionDuration: transitionDuration,
        onProgressCancel: onProgressCancel,
        onProgressError: onProgressError,
        onProgressFinish: onProgressFinish,
        onDismiss: onDismiss,
      );

  Future<T?> showCustomProgressDialog(
    BuildContext context, {
    Widget? loadingWidget,
    double? blur,
    Color? backgroundColor,
    DialogTransitionType? dialogTransitionType,
    bool? dismissable,
    Duration? transitionDuration,
    @Deprecated("Use try catch or .catchError instead") OnProgressError? onProgressError,
    @Deprecated("Use .then instead") OnProgressFinish? onProgressFinish,
    @Deprecated("Use .then instead") OnProgressCancel? onProgressCancel,
    Function? onDismiss,
  }) =>
      CustomProgressDialog.future<T?>(
        context,
        future: this,
        loadingWidget: loadingWidget,
        blur: blur,
        backgroundColor: backgroundColor,
        dialogTransitionType: dialogTransitionType,
        dismissable: dismissable,
        transitionDuration: transitionDuration,
        onProgressCancel: onProgressCancel,
        onProgressError: onProgressError,
        onProgressFinish: onProgressFinish,
        onDismiss: onDismiss,
      );
}
