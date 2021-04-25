///By Mochamad Nizwar Syafuan
///nizwar@merahputih.id
///==================================================================================
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ndialog/src/transition.dart';
import 'package:ndialog/src/utils.dart';
import 'package:ndialog/src/zoom_widget/zoom_widget.dart';
// import 'package:simple_animations/simple_animations.dart';

///NDialog widget
class NDialog extends StatelessWidget {
  ///Dialog style
  final DialogStyle? dialogStyle;

  ///The (optional) title of the dialog is displayed in a large font at the top of the dialog.
  final Widget? title;

  ///The (optional) content of the dialog is displayed in the center of the dialog in a lighter font.
  final Widget? content;

  ///The (optional) set of actions that are displayed at the bottom of the dialog.
  final List<Widget>? actions;

  const NDialog({Key? key, this.dialogStyle, this.title, this.content, this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData? theme = Theme.of(context);
    final DialogTheme? dialogTheme = DialogTheme.of(context);
    final DialogStyle style = dialogStyle ?? DialogStyle();

    String? label = style.semanticsLabel;
    Widget dialogChild = IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          title != null
              ? Padding(
                  padding: style.titlePadding,
                  child: DefaultTextStyle(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Semantics(
                          child: title,
                          namesRoute: true,
                          label: label,
                        ),
                        style.titleDivider
                            ? Divider()
                            : Container(
                                height: 10.0,
                              )
                      ],
                    ),
                    style: (style.titleTextStyle ?? (dialogTheme?.titleTextStyle)) ?? (theme?.textTheme.headline6 ?? TextStyle()),
                  ),
                )
              : Container(),
          content != null
              ? Flexible(
                  child: Padding(
                    padding: style.contentPadding,
                    child: DefaultTextStyle(
                      child: Semantics(child: content),
                      style: (style.contentTextStyle ?? dialogTheme?.contentTextStyle) ?? (theme?.textTheme.subtitle1 ?? TextStyle()),
                    ),
                  ),
                )
              : Container(),
          actions != null && (actions?.length ?? 0) > 0
              ? Theme(
                  data: ThemeData(
                    buttonTheme: ButtonThemeData(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                  child: (actions?.length ?? 0) <= 3
                      ? IntrinsicHeight(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(minHeight: 40),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: List.generate(
                                actions?.length ?? 0,
                                (index) {
                                  return Expanded(child: actions?[index] ?? SizedBox.shrink());
                                },
                              ),
                            ),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            actions?.length ?? 0,
                            (index) {
                              return SizedBox(
                                height: 50.0,
                                child: actions?[index],
                              );
                            },
                          ),
                        ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );

    return Padding(
      padding: MediaQuery.of(context).viewInsets + const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 280.0),
          child: Card(
            child: dialogChild,
            clipBehavior: Clip.antiAlias,
            elevation: style.elevation,
            color: style.backgroundColor,
            shape: style.borderRadius != null
                ? RoundedRectangleBorder(borderRadius: style.borderRadius ?? BorderRadius.circular(5))
                : style.shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
      ),
    );
  }

  Future<T?> show<T>(
    BuildContext context, {
    DialogTransitionType? transitionType,
    bool? dismissable,
    Duration? transitionDuration,
    Color? barrierColor,
  }) =>
      DialogUtils(
        child: this,
        dialogTransitionType: transitionType,
        dismissable: dismissable,
        barrierColor: barrierColor ?? generalBarrierColor,
        transitionDuration: transitionDuration,
      ).show(context);
}

///Simple dialog with blur background and popup animations, use DialogStyle to custom it
class NAlertDialog extends DialogBackground {
  ///Dialog style
  final DialogStyle? dialogStyle;

  ///The (optional) title of the dialog is displayed in a large font at the top of the dialog.
  final Widget? title;

  ///The (optional) content of the dialog is displayed in the center of the dialog in a lighter font.
  final Widget? content;

  ///The (optional) set of actions that are displayed at the bottom of the dialog.
  final List<Widget>? actions;

  /// Creates an background filter that applies a Gaussian blur.
  /// Default = 0
  final double? blur;

  ///Is your dialog dismissable?, because its warp by BlurDialogBackground,
  ///you have to declare here instead on showDialog
  final bool? dismissable;

  ///Its Barrier Color
  final Color? backgroundColor;

  ///Action before dialog dismissed
  final Function? onDismiss;

  const NAlertDialog({
    Key? key,
    this.backgroundColor,
    this.dialogStyle,
    this.title,
    this.content,
    this.actions,
    this.blur,
    this.dismissable,
    this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogBackground(
      dialog: NDialog(
        dialogStyle: dialogStyle,
        actions: actions,
        content: content,
        title: title,
      ),
      dismissable: dismissable,
      blur: blur,
      onDismiss: onDismiss,
      barrierColor: backgroundColor,
      key: key,
    );
  }
}

//A Dialog, but you can zoom on it
class ZoomDialog extends DialogBackground {
  ///The (optional) content of the dialog is displayed in the center of the dialog in a lighter font.
  final Widget? child;

  /// Creates an background filter that applies a Gaussian blur.
  /// Default = 0
  final double? blur;

  /// Background color
  final Color? backgroundColor;

  ///Maximum zoom scale
  final double zoomScale;

  ///Initialize zoom scale on dialog show
  final double initZoomScale;

  ///Action before dialog dismissed
  final Function? onDismiss;

  const ZoomDialog({Key? key, this.backgroundColor, @required this.child, this.initZoomScale = 0, this.blur, this.zoomScale = 3, this.onDismiss}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogBackground(
      key: key,
      dialog: Zoom(
        onTap: () {
          Navigator.pop(context);
          if (onDismiss != null) onDismiss?.call();
        },
        canvasColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        initZoom: initZoomScale,
        centerOnScale: true,
        maxZoomWidth: MediaQuery.of(context).size.width * zoomScale,
        maxZoomHeight: MediaQuery.of(context).size.height * zoomScale,
        child: Transform.scale(
          scale: zoomScale,
          child: Center(
            child: Container(
              child: child,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
        ),
      ),
      dismissable: true,
      blur: blur,
      onDismiss: onDismiss,
      barrierColor: backgroundColor,
    );
  }
}

///Blur background of dialog, you can use this class to make your custom dialog background blur
class DialogBackground extends StatelessWidget {
  ///Widget of dialog, you can use NDialog, Dialog, AlertDialog or Custom your own Dialog
  final Widget? dialog;

  ///Because blur dialog cover the barrier, you have to declare here
  final bool? dismissable;

  ///Action before dialog dismissed
  final Function? onDismiss;

  /// Creates an background filter that applies a Gaussian blur.
  /// Default = 0
  final double? blur;

  final Color? barrierColor;

  @Deprecated("Use barrierColor instead")
  final Color? color;

  const DialogBackground({Key? key, this.dialog, this.color, this.dismissable, this.blur, this.onDismiss, this.barrierColor}) : super(key: key);

  ///Show dialog directly
  // Future show<T>(BuildContext context) => showDialog<T>(context: context, builder: (context) => this, barrierColor: barrierColor, barrierDismissible: dismissable ?? true);

  Future<T?> show<T>(BuildContext context, {DialogTransitionType? transitionType, bool? dismissable, Duration? transitionDuration}) => DialogUtils(
        child: this,
        dialogTransitionType: transitionType,
        dismissable: dismissable,
        barrierColor: barrierColor ?? generalBarrierColor,
        transitionDuration: transitionDuration,
      ).show(context);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.canvas,
      color: Colors.transparent,
      child: WillPopScope(
        onWillPop: () async {
          if (dismissable ?? true) {
            if (onDismiss != null) onDismiss?.call();
            return true;
          }
          return false;
        },
        child: Stack(
          clipBehavior: Clip.antiAlias,
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            InkWell(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                if (dismissable ?? true) {
                  onDismiss?.call();
                  Navigator.pop(context);
                }
              },
              child: (blur ?? 0) < 1
                  ? Container()
                  : TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0.1, end: blur ?? 0),
                      duration: Duration(milliseconds: 300),
                      builder: (context, double? val, Widget? child) {
                        return BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: val ?? 0,
                            sigmaY: val ?? 0,
                          ),
                          child: Container(color: Colors.transparent),
                        );
                      },
                    ),
            ),
            dialog ?? SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

///Dialog style to custom your dialog
class DialogStyle {
  /// Divider on title
  final bool titleDivider;

  ///Set circular border radius for your dialog
  final BorderRadius? borderRadius;

  ///Set semanticslabel for Title
  final String semanticsLabel;

  ///Set padding for your Title
  final EdgeInsets titlePadding;

  ///Set padding for your  Content
  final EdgeInsets contentPadding;

  ///Set TextStyle for your Title
  final TextStyle? titleTextStyle;

  ///Set TextStyle for your Content
  final TextStyle? contentTextStyle;

  ///Elevation for dialog
  final double elevation;

  ///Background color of dialog
  final Color? backgroundColor;

  ///Shape for dialog, ignored if you set BorderRadius
  final ShapeBorder? shape;

  DialogStyle({
    this.titleDivider = false,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.semanticsLabel = "",
    this.titlePadding = const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
    this.contentPadding = const EdgeInsets.only(right: 15.0, left: 15.0, top: 0.0, bottom: 15.0),
    this.titleTextStyle,
    this.contentTextStyle,
    this.elevation = 24,
    this.backgroundColor,
    this.shape,
  });

  DialogStyle copyWith({
    bool? titleDivider,
    BorderRadius? borderRadius,
    String? semanticsLabel,
    EdgeInsets? titlePadding,
    EdgeInsets? contentPadding,
    TextStyle? titleTextStyle,
    TextStyle? contentTextStyle,
    double? elevation,
    Color? backgroundColor,
    ShapeBorder? shape,
  }) {
    return DialogStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      titleDivider: titleDivider ?? this.titleDivider,
      borderRadius: borderRadius ?? this.borderRadius,
      semanticsLabel: semanticsLabel ?? this.semanticsLabel,
      titlePadding: titlePadding ?? this.titlePadding,
      contentPadding: contentPadding ?? this.contentPadding,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      contentTextStyle: contentTextStyle ?? this.contentTextStyle,
      elevation: elevation ?? this.elevation,
    );
  }
}
