import 'dart:async';

///By Mochamad Nizwar Syafuan
///nizwar@merahputih.id
///==================================================================================
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

  Future show<T>(BuildContext context) =>
      showDialog<T>(context: context, builder: (context) => this);
}

///Simple dialog with blur background and popup animations, use DialogStyle to custom it
class NAlertDialog extends StatelessWidget {
  ///Custom progress dialog style
  final DialogStyle dialogStyle;

  ///The (optional) title of the dialog is displayed in a large font at the top of the dialog.
  final Widget title;

  ///The (optional) content of the dialog is displayed in the center of the dialog in a lighter font.
  final Widget content;

  ///The (optional) set of actions that are displayed at the bottom of the dialog.
  final List<Widget> actions;

  /// Creates an background filter that applies a Gaussian blur.
  /// Default = 3.0
  final double blur;

  ///Is your dialog dismissable?, because its warp by BlurDialogBackground,
  ///you have to declare here instead on showDialog
  final bool dismissable;

  ///Action before dialog dismissed
  final Function onDismiss;

  const NAlertDialog(
      {Key key,
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
    return BlurDialogBackground(
      dialog: NDialog(
        dialogStyle: dialogStyle,
        actions: actions,
        content: content,
        title: title,
      ),
      dismissable: dismissable,
      blur: blur ?? 0,
      onDismiss: onDismiss,
    );
  }

  ///Simply show dialog on NAlertdialog
  Future show<T>(BuildContext context) =>
      showDialog<T>(context: context, builder: (context) => this);
}

///Blur background of dialog, you can use this class to make your custom dialog background blur
class BlurDialogBackground extends StatelessWidget {
  ///Widget of dialog, you can use NDialog, Dialog, AlertDialog or Custom your own Dialog
  final Widget dialog;

  ///Because blur dialog cover the barrier, you have to declare here
  final bool dismissable;

  ///Action before dialog dismissed
  final Function onDismiss;

  /// Creates an background filter that applies a Gaussian blur.
  /// Default = 3.0
  final double blur;

  const BlurDialogBackground(
      {Key key, this.dialog, this.dismissable, this.blur, this.onDismiss})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.canvas,
      color: Colors.transparent,
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
            ]),
      ),
    );
  }
}

///Typedef of Progress while on Progress Error
typedef OnProgressError(dynamic error);

///Typedef of Progress while on Progress Finish
typedef OnProgressFinish<T>(T data);

///Typedef of Progress while on Progress Cancel
typedef OnProgressCancel();

///Simple progress dialog with blur background and popup animations, use DialogStyle to custom it
///inspired by ProgressDialog from Android Native, and it very simple to use
class ProgressDialog {
  ///The context
  final BuildContext context;

  ///Custom dialog style
  final DialogStyle dialogStyle;

  ///The (optional) title of the progress dialog is displayed in a large font at the top of the dialog.
  final Widget title;

  ///The (optional) message of the progress dialog is displayed in the center of the dialog in a lighter font.
  final Widget message;

  ///The (optional) on cancel button that will display at the bottom of the dialog.
  ///Note : Do not use POP to cancel the dialog, just put your cancel code there
  final Function onCancel;

  ///The (optional) cancel text that are displayed at the cancel button of the dialog.
  final Widget cancelText;

  ///The (optional) default progress widget that are displayed before message of the dialog,
  ///it will replaced when you use setLoadingWidget, and it will restored if you `setLoadingWidget(null)`.
  final Widget defaultLoadingWidget;

  ///Is your dialog dismissable?, because its warp by BlurDialogBackground,
  ///you have to declare here instead on showDialog
  final bool dismissable;

  ///Action on dialog dismissing
  final Function onDismiss;

  final double blur;

  bool _show = false;
  _ProgressDialogWidget _progressDialogWidget;

  ProgressDialog(this.context,
      {this.cancelText,
      this.defaultLoadingWidget,
      this.blur,
      this.onCancel,
      this.dismissable,
      this.onDismiss,
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

  ///You can set loading widget of dialog using this function,
  ///even the dialog already pop up.
  ///Set it Null to change it as default CircularProgressIndicator or loadingWidget that already you set before
  void setLoadingWidget(Widget loadingWidget) {
    _progressDialogWidget.getDialogState().setLoadingWidget(loadingWidget);
  }

  ///You can set message of dialog using this function,
  ///even the dialog already pop up
  void setMessage(Widget message) {
    _progressDialogWidget.getDialogState().setMessage(message);
  }

  ///Show progress dialog
  void show() async {
    if (!_show) {
      _show = true;
      if (_progressDialogWidget == null) _initProgress();
      await showDialog(
          context: context,
          barrierDismissible: dismissable ?? true,
          builder: (context) => _progressDialogWidget);
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
      dismissable: dismissable,
      onDismiss: onDismiss,
      message: message,
      blur: blur ?? 0,
      loadingWidget: defaultLoadingWidget,
    );
  }

  ///future function let you show ProgressDialog until future (param)
  ///reach the end of its action
  static Future future<T>(BuildContext context,
      {@required Future future,
      DialogStyle dialogStyle,
      double blur,
      OnProgressError onProgressError,
      OnProgressFinish onProgressFinish,
      OnProgressCancel onProgressCancel,
      Function onDismiss,
      bool dismissable,
      Widget message,
      Widget title,
      Widget cancelText,
      Widget progressWidget}) async {
    if (future == null) throw Exception("Future (param) can not be null");
    ProgressDialog pDialog = ProgressDialog(context,
        message: message,
        title: title,
        dismissable: dismissable,
        onDismiss: onDismiss,
        dialogStyle: dialogStyle,
        blur: blur,
        defaultLoadingWidget: progressWidget,
        cancelText: cancelText,
        onCancel: onProgressCancel != null
            ? () {
                onProgressCancel();
              }
            : null);

    pDialog.show();

    var output;
    await future.then((data) {
      if (onProgressFinish != null) onProgressFinish = onProgressFinish(data);
      output = data;
      pDialog.dismiss();
    }).catchError((error) {
      if (onProgressError != null) onProgressError = onProgressError(error);
      pDialog.dismiss();
    });

    return output;
  }
}

//ignore:must_be_immutable
class _ProgressDialogWidget extends StatefulWidget {
  final DialogStyle dialogStyle;
  final Widget title, message;
  final Widget cancelText;
  final Function onCancel;
  final Widget loadingWidget;
  final Function onDismiss;
  final bool dismissable;
  final double blur;
  _ProgressDialogWidgetState _dialogWidgetState = _ProgressDialogWidgetState();

  _ProgressDialogWidget({
    Key key,
    @required this.dialogStyle,
    this.title,
    this.message,
    this.onCancel,
    this.dismissable,
    this.onDismiss,
    this.cancelText,
    this.loadingWidget,
    this.blur,
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
  Widget title, message, loading;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final DialogTheme dialogTheme = DialogTheme.of(context);

    Widget titleDialog = title ?? widget.title;
    Widget messageDialog = message ?? widget.message;
    Widget loadingWidget = (loading ?? widget.loadingWidget) ??
        Container(
          padding: EdgeInsets.all(10.0),
          height: 50.0,
          width: 50.0,
          child: CircularProgressIndicator(
            strokeWidth: 3,
          ),
        );

    EdgeInsetsGeometry msgPadding = titleDialog == null
        ? EdgeInsets.all(15.0)
        : widget.onCancel == null
            ? widget.dialogStyle.contentPadding == null
                ? EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0)
                : widget.dialogStyle.contentPadding
            : EdgeInsets.fromLTRB(15.0, 0, 15.0, 0);

    return NAlertDialog(
      title: titleDialog,
      dismissable: widget.dismissable ?? true,
      blur: widget.blur,
      onDismiss: () {
        if (widget.onDismiss != null) {
          widget.onDismiss();
        }
        if (widget.onCancel != null) widget.onCancel();
      },
      dialogStyle: DialogStyle(
          backgroundColor: widget.dialogStyle.backgroundColor,
          titleDivider: widget.dialogStyle.titleDivider,
          borderRadius:
              widget.dialogStyle.borderRadius ?? BorderRadius.circular(2.0),
          contentPadding: msgPadding ?? EdgeInsets.symmetric(horizontal: 20.0),
          contentTextStyle: widget.dialogStyle.contentTextStyle,
          elevation: widget.dialogStyle.elevation,
          semanticsLabel: widget.dialogStyle.semanticsLabel,
          animatePopup: widget.dialogStyle.animatePopup ?? true,
          shape: widget.dialogStyle.shape,
          titlePadding: widget.dialogStyle.titlePadding ??
              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
          titleTextStyle: widget.dialogStyle.titleTextStyle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              loadingWidget,
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: DefaultTextStyle(
                  child: Semantics(child: messageDialog),
                  style: widget.dialogStyle.contentTextStyle ??
                      dialogTheme.contentTextStyle ??
                      theme.textTheme.subtitle1,
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

  ///Set loading widget of dialog
  void setLoadingWidget(Widget loading) async {
    this.loading = loading;
    if (mounted) setState(() {});
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
