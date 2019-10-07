import 'dart:async';

///By Mochamad Nizwar Syafuan
///nizwar@merahputih.id
///==================================================================================
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';

///Simple dialog with blur background and popup animations, use DialogStyle to custom it
class NDialog extends StatelessWidget {
  ///Custom progress dialog style
  final DialogStyle dialogStyle;

  ///The (optional) title of the dialog is displayed in a large font at the top of the dialog.
  final Widget title;

  ///The (optional) content of the dialog is displayed in the center of the dialog in a lighter font.
  final Widget content;

  ///The (optional) set of actions that are displayed at the bottom of the dialog.
  final List<Widget> actions;

  const NDialog(
      {Key key,
      @required this.dialogStyle,
      this.title,
      this.content,
      this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final DialogTheme dialogTheme = DialogTheme.of(context);
    final DialogStyle style = dialogStyle ?? DialogStyle();

    String label = style.semanticsLabel;
    Widget dialogChild = IntrinsicWidth(
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 280.0),
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
                          theme.textTheme.title,
                    ),
                  )
                : Container(),
            content != null
                ? Flexible(
                    child: SingleChildScrollView(
                      padding: style.contentPadding ??
                          EdgeInsets.only(
                              right: 15.0, left: 15.0, top: 0.0, bottom: 15.0),
                      child: DefaultTextStyle(
                        child: Semantics(child: content),
                        style: style.contentTextStyle ??
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
          if (style.barrierDismissable ?? true) {
            if (dialogStyle.onDismiss != null) dialogStyle.onDismiss();
            Navigator.pop(context);
          }
          return;
        },
        child: Stack(alignment: Alignment.center, children: <Widget>[
          GestureDetector(
            onTap: style.barrierDismissable ?? true
                ? () {
                    if (dialogStyle.onDismiss != null) dialogStyle.onDismiss();
                    Navigator.pop(context);
                  }
                : () {},
            child: ControlledAnimation(
              tween: Tween<double>(begin: 0, end: style.blur ?? 3),
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
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 32.0),
                      child: dialogChild,
                      clipBehavior: Clip.antiAlias,
                      elevation: style.elevation,
                      color: style.backgroundColor,
                      shape: style.borderRadius != null
                          ? RoundedRectangleBorder(
                              borderRadius: style.borderRadius)
                          : style.shape ??
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                    ));
              }),
        ]),
      ),
    );
  }
}

///Simple progress dialog with blur background and popup animations, use DialogStyle to custom it
class ProgressDialog {
  ///The context
  final BuildContext context;

  ///Custom progress dialog style
  final DialogStyle dialogStyle;

  ///The (optional) title of the progress dialog is displayed in a large font at the top of the dialog.
  final Widget title;

  ///The (optional) message of the progress dialog is displayed in the center of the dialog in a lighter font.
  final Widget message;

  ///The (optional) on cancel button that will display at the bottom of the dialog.
  ///
  ///Note : Do not use POP to cancel the dialog, just put your cancel code there
  final Function onCancel;

  ///The (optional) cancel text that are displayed at the cancel button of the dialog.
  final Widget cancelText;

  ///The (optional) progress widget that are displayed before message of the dialog.
  final Widget progressWidget;

  bool _show = false;
  _ProgressDialogWidget _progressDialogWidget;

  ///Progress dialog is inspired by ProgressDialog from Android Native,
  ///its very simple to use
  ProgressDialog(this.context,
      {this.cancelText,
      this.progressWidget,
      this.onCancel,
      this.title,
      this.message,
      this.dialogStyle}) {
    _initProgress();
  }

  ///You can set title of dialog using this function,
  ///even the dialog already pop up
  void setTitle(Widget title) {
    _progressDialogWidget.getDialogState().setTitle(title);
  }

  ///You can set message of dialog using this function,
  ///even the dialog already pop up
  void setMessage(Widget message) {
    _progressDialogWidget.getDialogState().setMessage(message);
  }

  ///Show progress dialog
  void show() async {
    DialogStyle style = dialogStyle ?? DialogStyle();
    if (!_show) {
      _show = true;
      if (_progressDialogWidget == null) _initProgress();
      await showDialog(
          context: context,
          barrierDismissible: style.barrierDismissable ?? true,
          builder: (context) {
            return _progressDialogWidget;
          });
      _show = false;
    }
  }

  ///Dismiss the dialog
  void dismiss() {
    if (_show) {
      _show = false;
      Navigator.pop(context);
    }
  }

  void _initProgress() {
    _progressDialogWidget = _ProgressDialogWidget(
      dialogStyle: dialogStyle ?? DialogStyle(),
      onCancel: onCancel,
      cancelText: cancelText,
      title: title,
      message: message,
      progressWidget: progressWidget,
    );
  }

  ///future function let you show ProgressDialog until future (param)
  ///reach the end of its action
  static Future future(BuildContext context,
      {@required Future future,
      DialogStyle dialogStyle,
      OnProgressError onProgressError,
      OnProgressFinish onProgressFinish,
      OnProgressCancel onProgressCancel,
      Widget message,
      Widget title,
      Widget cancelText,
      Widget progressWidget}) async {
    if (future == null) throw Exception("Future (param) can not be null");
    ProgressDialog pDialog = ProgressDialog(context,
        message: message,
        title: title,
        dialogStyle: dialogStyle,
        progressWidget: progressWidget,
        cancelText: cancelText,
        onCancel: onProgressCancel != null
            ? () {
                onProgressCancel();
              }
            : null);

    pDialog.show();

    return await future.then((data) {
      if (onProgressFinish != null) onProgressFinish = onProgressFinish(data);
      pDialog.dismiss();
    }).catchError((error) {
      if (onProgressError != null) onProgressError = onProgressError(error);
      pDialog.dismiss();
    });
  }
}

///Typedef of Progress while on Progress Error
typedef OnProgressError(dynamic error);

///Typedef of Progress while on Progress Finish
typedef OnProgressFinish(dynamic data);

///Typedef of Progress while on Progress Cancel
typedef OnProgressCancel();

//ignore:must_be_immutable
class _ProgressDialogWidget extends StatefulWidget {
  final DialogStyle dialogStyle;
  final Widget title, message;
  final Widget cancelText;
  final Function onCancel;
  final Widget progressWidget;
  _ProgressDialogWidgetState _dialogWidgetState = _ProgressDialogWidgetState();

  _ProgressDialogWidget({
    Key key,
    @required this.dialogStyle,
    this.title,
    this.message,
    this.onCancel,
    this.cancelText,
    this.progressWidget,
  }) : super(key: key);

  @override
  _ProgressDialogWidgetState createState() {
    if (_dialogWidgetState == null) {
      _dialogWidgetState = _ProgressDialogWidgetState();
    }
    return _dialogWidgetState;
  }

  _ProgressDialogWidgetState getDialogState() {
    if (_dialogWidgetState == null) {
      _dialogWidgetState = _ProgressDialogWidgetState();
    }
    return _dialogWidgetState;
  }
}

class _ProgressDialogWidgetState extends State<_ProgressDialogWidget> {
  Widget title, message;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final DialogTheme dialogTheme = DialogTheme.of(context);

    Widget titleDialog = title ?? widget.title;
    Widget messageDialog = message ?? widget.message;

    EdgeInsetsGeometry msgPadding = titleDialog == null
        ? EdgeInsets.all(15.0)
        : widget.onCancel == null
            ? widget.dialogStyle.contentPadding == null
                ? EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0)
                : widget.dialogStyle.contentPadding
            : EdgeInsets.fromLTRB(15.0, 0, 15.0, 0);

    return NDialog(
      title: titleDialog,
      dialogStyle: DialogStyle(
          backgroundColor: widget.dialogStyle.backgroundColor,
          blur: widget.dialogStyle.blur,
          titleDivider: widget.dialogStyle.titleDivider,
          barrierDismissable: widget.dialogStyle.barrierDismissable,
          borderRadius:
              widget.dialogStyle.borderRadius ?? BorderRadius.circular(2.0),
          contentPadding: msgPadding ?? EdgeInsets.symmetric(horizontal: 20.0),
          contentTextStyle: widget.dialogStyle.contentTextStyle,
          elevation: widget.dialogStyle.elevation,
          semanticsLabel: widget.dialogStyle.semanticsLabel,
          shape: widget.dialogStyle.shape,
          titlePadding: widget.dialogStyle.titlePadding ??
              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
          onDismiss: () {
            if (widget.dialogStyle.onDismiss != null) {
              widget.dialogStyle.onDismiss();
            }
            if (widget.onCancel != null) widget.onCancel();
          },
          titleTextStyle: widget.dialogStyle.titleTextStyle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              widget.progressWidget ??
                  Container(
                    padding: EdgeInsets.all(10.0),
                    height: 50.0,
                    width: 50.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: DefaultTextStyle(
                  child: Semantics(child: messageDialog),
                  style: widget.dialogStyle.contentTextStyle ??
                      dialogTheme.contentTextStyle ??
                      theme.textTheme.subhead,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: widget.onCancel == null
          ? []
          : [
              Container(
                padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                alignment: Alignment.centerRight,
                child: FlatButton(
                  padding: EdgeInsets.only(),
                  highlightColor: Colors.white.withOpacity(.3),
                  splashColor: Theme.of(context).accentColor.withOpacity(.2),
                  onPressed: () {
                    if (widget.onCancel != null) widget.onCancel();
                    Navigator.pop(context);
                  },
                  child: DefaultTextStyle(
                    child: widget.cancelText ?? Text("Cancel"),
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                ),
              )
            ],
    );
  }

  ///Set title of dialog
  void setTitle(Widget title) async {
    this.title = title;
    if (mounted) setState(() {});
  }

  ///Set message of dialog
  void setMessage(Widget message) async {
    this.message = message;
    if (mounted) setState(() {});
  }
}

///Dialog style to custom your dialog
class DialogStyle {
  /// Creates an background filter that applies a Gaussian blur.
  ///
  /// Default = 3.0
  final double blur;

  /// is your dialog Dismissable while you click outside box?
  final bool barrierDismissable;

  final Function onDismiss;

  /// Divider on title
  final bool titleDivider;

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

  DialogStyle(
      {this.titleDivider,
      this.blur,
      this.onDismiss,
      this.barrierDismissable,
      this.borderRadius,
      this.semanticsLabel,
      this.titlePadding,
      this.contentPadding,
      this.titleTextStyle,
      this.contentTextStyle,
      this.elevation,
      this.backgroundColor,
      this.shape});
}
