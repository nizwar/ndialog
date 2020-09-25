///By Mochamad Nizwar Syafuan
///nizwar@merahputih.id
///==================================================================================
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

///NDialog widget
class NDialog extends StatelessWidget {
  ///Custom dialog style
  final DialogStyle dialogStyle;

  ///The (optional) title of the dialog is displayed in a large font at the top of the dialog.
  final Widget title;

  ///The (optional) content of the dialog is displayed in the center of the dialog in a lighter font.
  final Widget content;

  ///The (optional) set of actions that are displayed at the bottom of the dialog.
  final List<Widget> actions;

  const NDialog(
      {Key key, this.dialogStyle, this.title, this.content, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final DialogTheme dialogTheme = DialogTheme.of(context);
    final DialogStyle style = dialogStyle ?? DialogStyle();

    String label = style.semanticsLabel;
    Widget dialogChild = IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          title != null
              ? Padding(
                  padding: style.titlePadding ??
                      EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                  child: DefaultTextStyle(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Semantics(
                          child: title,
                          namesRoute: true,
                          label: label,
                        ),
                        style.titleDivider ?? false
                            ? Divider()
                            : Container(
                                height: 10.0,
                              )
                      ],
                    ),
                    style: style.titleTextStyle ??
                        dialogTheme.titleTextStyle ??
                        theme.textTheme.headline6,
                  ),
                )
              : Container(),
          content != null
              ? Flexible(
                  child: Padding(
                    padding: style.contentPadding ??
                        EdgeInsets.only(
                            right: 15.0, left: 15.0, top: 0.0, bottom: 15.0),
                    child: DefaultTextStyle(
                      child: Semantics(child: content),
                      style: style.contentTextStyle ??
                          dialogTheme.contentTextStyle ??
                          theme.textTheme.subtitle1,
                    ),
                  ),
                )
              : Container(),
          actions != null
              ? Theme(
                  data: ThemeData(
                    buttonTheme: ButtonThemeData(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                  child: actions.length <= 3
                      ? IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: List.generate(
                              actions.length,
                              (index) {
                                return Expanded(child: actions[index]);
                              },
                            ),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            actions.length,
                            (index) {
                              return SizedBox(
                                height: 50.0,
                                child: actions[index],
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
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 280.0),
          child: (style?.animatePopup ?? true)
              ? CustomAnimation(
                  tween: Tween<double>(begin: 0, end: 1),
                  curve: Curves.elasticOut,
                  duration: Duration(milliseconds: 900),
                  builder: (context, child, val) {
                    return Transform.scale(
                        scale: val,
                        child: Card(
                          child: dialogChild,
                          clipBehavior: Clip.antiAlias,
                          elevation: style.elevation ?? 24,
                          color: style.backgroundColor,
                          shape: style.borderRadius != null
                              ? RoundedRectangleBorder(
                                  borderRadius: style.borderRadius)
                              : style.shape ??
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                        ));
                  })
              : Card(
                  child: dialogChild,
                  clipBehavior: Clip.antiAlias,
                  elevation: style.elevation ?? 24,
                  color: style.backgroundColor,
                  shape: style.borderRadius != null
                      ? RoundedRectangleBorder(borderRadius: style.borderRadius)
                      : style.shape ??
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                ),
        ),
      ),
    );
  }

  ///Show dialog directly
  Future show<T>(BuildContext context) => showDialog<T>(
        context: context,
        builder: (context) => this,
      );
}

///Simple dialog with blur background and popup animations, use DialogStyle to custom it
class NAlertDialog extends DialogBackground {
  ///Custom progress dialog style
  final DialogStyle dialogStyle;

  ///The (optional) title of the dialog is displayed in a large font at the top of the dialog.
  final Widget title;

  ///The (optional) content of the dialog is displayed in the center of the dialog in a lighter font.
  final Widget content;

  ///The (optional) set of actions that are displayed at the bottom of the dialog.
  final List<Widget> actions;

  /// Creates an background filter that applies a Gaussian blur.
  /// Default = 0
  final double blur;

  ///Is your dialog dismissable?, because its warp by BlurDialogBackground,
  ///you have to declare here instead on showDialog
  final bool dismissable;

  final Color backgroundColor;

  ///Action before dialog dismissed
  final Function onDismiss;

  const NAlertDialog(
      {Key key,
      this.backgroundColor,
      this.dialogStyle,
      this.title,
      this.content,
      this.actions,
      this.blur,
      this.dismissable,
      this.onDismiss})
      : super(key: key);

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
      blur: blur ?? 0,
      onDismiss: onDismiss,
      color: backgroundColor,
    );
  }
}

@deprecated
class BlurDialogBackground extends DialogBackground {
  ///Widget of dialog, you can use NDialog, Dialog, AlertDialog or Custom your own Dialog
  final Widget dialog;

  ///Because blur dialog cover the barrier, you have to declare here
  final bool dismissable;

  ///Action before dialog dismissed
  final Function onDismiss;

  /// Creates an background filter that applies a Gaussian blur.
  /// Default = 0
  final double blur;

  /// Background color
  final Color color;

  const BlurDialogBackground(
      {Key key,
      this.color,
      this.dialog,
      this.dismissable,
      this.blur,
      this.onDismiss})
      : super(key: key);
}

///Blur background of dialog, you can use this class to make your custom dialog background blur
class DialogBackground extends StatelessWidget {
  ///Widget of dialog, you can use NDialog, Dialog, AlertDialog or Custom your own Dialog
  final Widget dialog;

  ///Because blur dialog cover the barrier, you have to declare here
  final bool dismissable;

  ///Action before dialog dismissed
  final Function onDismiss;

  /// Creates an background filter that applies a Gaussian blur.
  /// Default = 0
  final double blur;

  /// Background color
  final Color color;

  const DialogBackground(
      {Key key,
      this.dialog,
      this.dismissable,
      this.blur,
      this.onDismiss,
      this.color})
      : super(key: key);

  ///Show dialog directly
  Future show<T>(BuildContext context) => showDialog<T>(
      context: context,
      builder: (context) => this,
      barrierColor: Color(0x00ffffff),
      barrierDismissible: dismissable ?? true);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.canvas,
      color: color ?? Colors.black.withOpacity(.6),
      child: WillPopScope(
        onWillPop: () async {
          if (dismissable ?? true) {
            if (onDismiss != null) onDismiss();
            Navigator.pop(context);
          }
          return;
        },
        child: Stack(
          overflow: Overflow.clip,
          clipBehavior: Clip.antiAlias,
          alignment: Alignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: dismissable ?? true
                  ? () {
                      if (onDismiss != null) {
                        onDismiss();
                      }
                      Navigator.pop(context);
                    }
                  : () {},
              child: CustomAnimation(
                tween: Tween<double>(begin: 0, end: blur ?? 0),
                duration: Duration(milliseconds: 300),
                builder: (context, child, val) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: val,
                      sigmaY: val,
                    ),
                    child: Container(
                      color: Colors.transparent,
                    ),
                  );
                },
              ),
            ),
            dialog
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
  final BorderRadius borderRadius;

  ///Set semanticslabel for Title
  final String semanticsLabel;

  ///Set padding for your Title
  final EdgeInsets titlePadding;

  ///Set padding for your  Content
  final EdgeInsets contentPadding;

  ///Set TextStyle for your Title
  final TextStyle titleTextStyle;

  ///Set TextStyle for your Content
  final TextStyle contentTextStyle;

  ///Elevation for dialog
  final double elevation;

  ///Background color of dialog
  final Color backgroundColor;

  ///Shape for dialog, ignored if you set BorderRadius
  final ShapeBorder shape;

  ///Bubble animation when your dialog will popup
  final bool animatePopup;

  DialogStyle(
      {this.titleDivider,
      this.borderRadius,
      this.semanticsLabel,
      this.titlePadding,
      this.contentPadding,
      this.titleTextStyle,
      this.contentTextStyle,
      this.elevation,
      this.backgroundColor,
      this.animatePopup,
      this.shape});
}
