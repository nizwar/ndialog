import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blur Dialog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
          OutlinedButton(
            child: Text("NAlertDialog show"),
            onPressed: () {
              NAlertDialog(
                title: Text("Test"),
                content: Text("Iya iya"),
                blur: 2,
              ).show(context, transitionType: DialogTransitionType.Bubble);
            },
          ),
          OutlinedButton(
            child: Text("NDialog can do it too!"),
            onPressed: () {
              NDialog(
                title: Text("Test"),
                dialogStyle: DialogStyle(),
                content: Text("Iya iya"),
              ).show(context);
            },
          ),
          OutlinedButton(
            child: Text("Progress Dialog"),
            onPressed: () async {
              ProgressDialog progressDialog = ProgressDialog(context, blur: 0, dialogTransitionType: DialogTransitionType.Shrink,
                  // transitionDuration: Duration(milliseconds: 100),
                  onDismiss: () {
                print("Do something onDismiss");
              });
              progressDialog.setLoadingWidget(CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.red),
              ));
              progressDialog.setMessage(Text("Please Wait, Injecting your phone with my virus"));
              progressDialog.setTitle(Text("Loading"));
              progressDialog.show();

              await Future.delayed(Duration(seconds: 5));

              progressDialog.setMessage(Text("I mean, virus of love :*"));
              progressDialog.setLoadingWidget(null);
              progressDialog.setTitle(Text("Just Kidding"));

              await Future.delayed(Duration(seconds: 5));

              progressDialog.dismiss();
            },
          ),
          OutlinedButton(
            onPressed: () async {
              CustomProgressDialog progressDialog = CustomProgressDialog(
                context,
                blur: 10,
                onDismiss: () {
                  print("Do something onDismiss");
                },
              );
              progressDialog.setLoadingWidget(CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.red),
              ));
              progressDialog.show();

              await Future.delayed(Duration(seconds: 5));
              progressDialog.setLoadingWidget(null);

              await Future.delayed(Duration(seconds: 5));

              progressDialog.dismiss();
            },
            child: Text("Custom Progress Dialog"),
          ),
          OutlinedButton(
            onPressed: () async {
              print(await ProgressDialog.future(
                context,
                blur: 0.0,
                future: Future.delayed(Duration(seconds: 5), () {
                  return "HIYAAA";
                }),
                onProgressError: (error) {
                  print("Do something onProgressError");
                },
                onProgressFinish: (data) {
                  print("Do something onProgressFinish");
                },
                onDismiss: () {
                  print("Dismissed");
                },
                message: Text("Please Wait"),
                cancelText: Text("Batal"),
                title: Text("Loging in"),
              ));
            },
            child: Text("Progress Dialog Future"),
          ),
          OutlinedButton(
            child: Text("Custom Progress Dialog Future"),
            onPressed: () async {
              print(await CustomProgressDialog.future(
                context,
                backgroundColor: Colors.blue.withOpacity(.5),
                future: Future.delayed(Duration(seconds: 5), () {
                  return "WOHOOO";
                }),
                onProgressError: (error) {
                  print("Do something onProgressError");
                },
                onProgressFinish: (data) {
                  print("Do something onProgressFinish");
                },
                onDismiss: () {
                  print("Dismissed");
                },
              ));
            },
          ),
          OutlinedButton(
            onPressed: () async {
              NAlertDialog(
                dialogStyle: DialogStyle(titleDivider: true),
                title: Text("Hi, This is NAlertDialog"),
                content: Text("And here is your content, hoho... "),
                actions: <Widget>[
                  OutlinedButton(
                    child: Text("You"),
                    onPressed: () {},
                  ),
                  OutlinedButton(
                    child: Text("Are"),
                    onPressed: () {},
                  ),
                  OutlinedButton(
                    child: Text("Awesome"),
                    onPressed: () {},
                  )
                ],
              ).show(context);
            },
            child: Text("Show NAlertDialog"),
          ),
          OutlinedButton(
            onPressed: () async {
              NDialog(
                dialogStyle: DialogStyle(titleDivider: true),
                title: Text("Hi, This is NDialog"),
                content: Text("And here is your content, hoho... "),
                actions: <Widget>[
                  OutlinedButton(
                    child: Text("You"),
                    onPressed: () {},
                  ),
                  OutlinedButton(
                    child: Text("Are"),
                    onPressed: () {},
                  ),
                  OutlinedButton(
                    child: Text("Awesome"),
                    onPressed: () {},
                  )
                ],
              ).show(
                context,
              );
            },
            child: Text("Show NDialog"),
          ),
          OutlinedButton(
            child: Text(
              "Show Alert Dialog\nWith Blur Background",
              textAlign: TextAlign.center,
            ),
            onPressed: () async {
              DialogBackground(
                barrierColor: Colors.red.withOpacity(.5),
                blur: 0,
                dialog: AlertDialog(
                  title: Text("Alert Dialog"),
                  content: Text("Wohoo.. This is ordinary AlertDialog with Blur background"),
                  actions: <Widget>[
                    OutlinedButton(
                      child: Text("You"),
                      onPressed: () {},
                    ),
                    OutlinedButton(
                      child: Text("Are"),
                      onPressed: () {},
                    ),
                    OutlinedButton(
                      child: Text("Awesome"),
                      onPressed: () {},
                    )
                  ],
                ),
              ).show(
                context,
              );
            },
          ),
          OutlinedButton(
            child: Text(
              "Show Alert Dialog\nWith Custom Background Color",
              textAlign: TextAlign.center,
            ),
            onPressed: () async {
              NAlertDialog(
                backgroundColor: Colors.red.withOpacity(.5),
                blur: 0,
                title: Text("Alert Dialog"),
                content: Text("Wohoo.. This is ordinary AlertDialog with Custom Color background"),
                actions: <Widget>[
                  OutlinedButton(
                    child: Text("You"),
                    onPressed: () {},
                  ),
                  OutlinedButton(
                    child: Text("Are"),
                    onPressed: () {},
                  ),
                  OutlinedButton(
                    child: Text("Awesome"),
                    onPressed: () {},
                  )
                ],
              ).show(context);
            },
          ),
          OutlinedButton(
            child: Text(
              "Dialog Extension",
              textAlign: TextAlign.center,
            ),
            onPressed: () async {
              await AlertDialog(
                title: Text("Alert Dialog"),
                content: Text("Wohoo.. This is ordinary AlertDialog with Blur background"),
                actions: <Widget>[
                  OutlinedButton(
                    child: Text("You"),
                    onPressed: () {},
                  ),
                  OutlinedButton(
                    child: Text("Are"),
                    onPressed: () {},
                  ),
                  OutlinedButton(
                    child: Text("Awesome"),
                    onPressed: () {},
                  )
                ],
              ).show(context);
            },
          ),
          OutlinedButton(
            child: Text("CupertinoDialog Extension", textAlign: TextAlign.center),
            onPressed: () async {
              await CupertinoAlertDialog(
                title: Text("Alert Dialog"),
                content: Text("Wohoo.. This is ordinary AlertDialog with Blur background"),
                actions: <Widget>[
                  OutlinedButton(
                    child: Text("You"),
                    onPressed: () {},
                  ),
                  OutlinedButton(
                    child: Text("Are"),
                    onPressed: () {},
                  ),
                  OutlinedButton(
                    child: Text("Awesome"),
                    onPressed: () {},
                  )
                ],
              ).show(context);
            },
          ),
          OutlinedButton(
            child: Text("ZoomDIALOG", textAlign: TextAlign.center),
            onPressed: () async {
              await ZoomDialog(
                zoomScale: 5,
                blur: 10,
                child: Container(
                  child: Text("Zoom me!"),
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                ),
              ).show(context);
            },
          ),
        ]
            .map((e) => Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: e,
                ))
            .toList(),
      ),
    );
  }
}
