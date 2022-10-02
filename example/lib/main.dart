import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blur Dialog',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'Example BlurDialog'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          ///Show NAlertDialog
          _button("Show NAlertDialog", () {
            NAlertDialog(
              dialogStyle: DialogStyle(titleDivider: true),
              title: Text("NAlertDialog"),
              content: Text("This is NAlertDialog's content"),
              actions: <Widget>[
                TextButton(
                    child: Text("Okay"),
                    onPressed: () => Navigator.pop(context)),
                TextButton(
                    child: Text("Close"),
                    onPressed: () => Navigator.pop(context)),
              ],
            ).show(context);
          }),

          ///Show NDialog
          _button("Show NDialog", () {
            NDialog(
              dialogStyle: DialogStyle(titleDivider: true),
              title: Text("NDialog"),
              content: Text("This is NDialog's content"),
              actions: <Widget>[
                TextButton(
                    child: Text("Okay"),
                    onPressed: () => Navigator.pop(context)),
                TextButton(
                    child: Text("Close"),
                    onPressed: () => Navigator.pop(context)),
              ],
            ).show(context);
          }),

          ///Show ProgressDialog traditional way
          _button("Show ProgressDialog traditional way", () async {
            ProgressDialog progressDialog = ProgressDialog(
              context,
              blur: 10,
              title: Text("Title of ProgressDialog"),
              message: Text("Content of ProgressDialog"),
              onDismiss: () => print("Do something onDismiss"),
            );
            progressDialog.show();

            //Set loading with red circular progress indicator and change the title and message
            await Future.delayed(Duration(seconds: 5));
            progressDialog.setLoadingWidget(CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.red)));
            progressDialog.setTitle(Text("ProgressDialog Title changed"));
            progressDialog
                .setMessage(Text("It will change again after 5 seconds"));

            //Show dialog
            progressDialog.show();

            //After 5 seconds, change the title, message and loading widget to null (default widget is CircularProgressIndicator)
            await Future.delayed(Duration(seconds: 5));
            progressDialog.setLoadingWidget(null);
            progressDialog.setMessage(
                Text("ProgressDialog will dismiss after 5 seconds"));
            progressDialog.setTitle(Text("Last changes"));

            //After 5 seconds, dismiss the dialog
            await Future.delayed(Duration(seconds: 5));
            progressDialog.dismiss();
          }),

          ///Show ProgressDialog traditional way
          _button("Show CustomProgressDialog traditional way", () async {
            CustomProgressDialog progressDialog = CustomProgressDialog(
              context,
              blur: 10,
              onDismiss: () => print("Do something onDismiss"),
            );

            //Set loading with red circular progress indicator
            progressDialog.setLoadingWidget(CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.red)));

            //Show dialog
            progressDialog.show();

            //After 5 seconds, change the loading widget to null (default widget is CircularProgressIndicator)
            await Future.delayed(Duration(seconds: 5));
            progressDialog.setLoadingWidget(null);

            //After 5 seconds, dismiss the dialog
            await Future.delayed(Duration(seconds: 5));
            progressDialog.dismiss();
          }),

          ///Show ProgressDialog with Future's static function
          _button("Show ProgressDialog.future()", () {
            ProgressDialog.future(
              context,
              title: Text("ProgressDialog.future()"),
              message: Text("This will finish after 5 seconds"),
              future: Future.delayed(
                  Duration(seconds: 5), () => "The end of future (5 seconds)"),
              onProgressError: (error) => print("Do something onProgressError"),
              onProgressFinish: (data) =>
                  print("Do something onProgressFinish"),
              onDismiss: () => print("Dismissed"),
            ).then((value) => print(value));
          }),

          ///Show CustomProgressDialog with Future's static function
          _button("Show CustomProgressDialog.future()", () {
            CustomProgressDialog.future(
              context,
              future: Future.delayed(
                  Duration(seconds: 5), () => "The end of future (5 seconds)"),
              onProgressError: (error) => print("Do something onProgressError"),
              onProgressFinish: (data) =>
                  print("Do something onProgressFinish"),
              onDismiss: () => print("Dismissed"),
            ).then((value) => print(value));
          }),

          ///Show Progress Dialog from NDialog Future's extensions
          _button("Show ProgressDialog from extension", () async {
            Future.delayed(Duration(seconds: 3)).showProgressDialog(
              context,
              title: Text("Title of ProgressDialog"),
              message: Text("This dialog will be close after 3 seconds"),
            );
          }),

          ///Show Custom Progress Dialog from NDialog Future's extensions
          _button("Show CustomProgressDialog from extension", () async {
            Future.delayed(Duration(seconds: 3))
                .showCustomProgressDialog(context);
          }),

          ///Show NAlertDialog with blur background
          _button("NAlertDialog with blur background", () {
            DialogBackground(
              blur: 5,
              dialog: AlertDialog(
                title: Text("NAlert Dialog"),
                content: Text("NAlertDialog with Blur background"),
                actions: <Widget>[
                  TextButton(
                      child: Text("Okay"),
                      onPressed: () => Navigator.pop(context)),
                  TextButton(
                      child: Text("Close"),
                      onPressed: () => Navigator.pop(context)),
                ],
              ),
            ).show(context);
          }),

          ///Show NAlertDialog with custom background color
          _button("NAlertDialog with backgroundColor", () {
            NAlertDialog(
              backgroundColor: Colors.red.withOpacity(.5),
              blur: 0,
              title: Text("NAlert Dialog"),
              content: Text("NAlertDialog with custom Color background"),
              actions: <Widget>[
                TextButton(
                    child: Text("Okay"),
                    onPressed: () => Navigator.pop(context)),
                TextButton(
                    child: Text("Close"),
                    onPressed: () => Navigator.pop(context)),
              ],
            ).show(context);
          }),

          ///Show material alret dialog with NDialog show Extensions
          _button("AlertDialog extensions", () {
            AlertDialog(
              title: Text("Material AlertDialog"),
              content: Text("This dialog shown from NDialog extensions"),
              actions: <Widget>[
                TextButton(
                    child: Text("Okay"),
                    onPressed: () => Navigator.pop(context)),
                TextButton(
                    child: Text("Close"),
                    onPressed: () => Navigator.pop(context)),
              ],
            ).show(context);
          }),

          ///Show cupertino alret dialog with NDialog show Extensions
          _button("CupertinoAlertDialog extensions", () {
            CupertinoAlertDialog(
              title: Text("Cupertino Alert Dialog"),
              content: Text("This dialog shown from NDialog extensions"),
              actions: <Widget>[
                CupertinoButton(
                    child: Text("Okay"),
                    onPressed: () => Navigator.pop(context)),
                CupertinoButton(
                    child: Text("Close"),
                    onPressed: () => Navigator.pop(context)),
              ],
            ).show(context);
          }),

          ///Show zoomable widget in dialog
          _button("Show ZoomDialog", () {
            ZoomDialog(
              zoomScale: 5,
              blur: 10,
              child: Container(
                child: Text("Zoom me!"),
                color: Colors.white,
                padding: EdgeInsets.all(20),
              ),
            ).show(context);
          }),
        ]
            .map((e) =>
                Container(margin: EdgeInsets.symmetric(vertical: 5), child: e))
            .toList(),
      ),
    );
  }

  Widget _button(String title, Function() onPressed) {
    return OutlinedButton(child: Text(title), onPressed: onPressed);
  }
}
