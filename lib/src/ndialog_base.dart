///By Mochamad Nizwar Syafuan
///nizwar@merahputih.id
///==================================================================================
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';

///Simple dialog with blur background and popup animation
class NDialog extends StatelessWidget {
  /// Creates an background filter that applies a Gaussian blur.
  ///
  /// Default = 3.0
  final double blur;

  /// Same as alertdialog, you have to add Title and Content
  final Widget title, content;

  /// Same as alertdialog, you have to add Actions
  final List<Widget> actions;

  /// is your dialog Dismissable while you click outside box?
  final bool barrierDismissible;

  ///Set circular border radius for your dialog
  final BorderRadius borderRadius;

  ///Set semanticslabel for Title
  final String semanticsLabel;

  ///Set padding for your Title or Content
  final EdgeInsets titlePadding, contentPadding;

  ///Set TextStyle for your Title or Content
  final TextStyle titleTextStyle, contentTextStyle;

  ///Elevation for dialog
  final double elevation;

  ///Background color of dialog
  final Color backgroundColor;

  ///Shape for dialog, ignored if you set BorderRadius
  final ShapeBorder shape;

  const NDialog(
      {Key key,
      this.blur,
      this.title,
      @required this.content,
      this.actions,
      this.barrierDismissible,
      this.borderRadius,
      this.semanticsLabel,
      this.titlePadding,
      this.contentPadding,
      this.titleTextStyle,
      this.contentTextStyle,
      this.elevation,
      this.backgroundColor,
      this.shape})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final DialogTheme dialogTheme = DialogTheme.of(context);

    String label = semanticsLabel;
    Widget dialogChild = IntrinsicWidth(
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 280.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            title != null
                ? Padding(
                    padding: titlePadding ??
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
                          Divider()
                        ],
                      ),
                      style: titleTextStyle ??
                          dialogTheme.titleTextStyle ??
                          theme.textTheme.title,
                    ),
                  )
                : Container(),
            content != null
                ? Flexible(
                    child: SingleChildScrollView(
                      padding: contentPadding ??
                          EdgeInsets.only(
                              right: 15.0, left: 15.0, top: 0.0, bottom: 15.0),
                      child: DefaultTextStyle(
                        child: Semantics(child: content),
                        style: contentTextStyle ??
                            dialogTheme.contentTextStyle ??
                            theme.textTheme.subhead,
                      ),
                    ),
                  )
                : Container(),
            actions != null
                ? actions.length <= 3
                    ? IntrinsicHeight(
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: List.generate(actions.length, (index) {
                              return Expanded(child: actions[index]);
                            })))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(actions.length, (index) {
                          return SizedBox(
                            height: 50.0,
                            child: actions[index],
                          );
                        }))
                : Container(),
          ],
        ),
      ),
    );

    return Material(
      type: MaterialType.canvas,
      color: Colors.transparent,
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return;
        },
        child: Stack(alignment: Alignment.center, children: <Widget>[
          GestureDetector(
            onTap: barrierDismissible ?? true
                ? () {
                    Navigator.pop(context);
                  }
                : () {},
            child: ControlledAnimation(
              tween: Tween<double>(begin: 0, end: blur ?? 3),
              duration: Duration(milliseconds: 300),
              builder: (context, val) {
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
          ControlledAnimation(
              tween: Tween<double>(begin: 0, end: 1),
              curve: Curves.elasticOut,
              duration: Duration(milliseconds: 900),
              builder: (context, val) {
                return Transform.scale(
                  scale: val,
                  child: Dialog(
                    backgroundColor: backgroundColor,
                    elevation: elevation,
                    child: dialogChild,
                    shape: borderRadius != null
                        ? RoundedRectangleBorder(borderRadius: borderRadius)
                        : shape ??
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                  ),
                );
              }),
        ]),
      ),
    );
  }
}
