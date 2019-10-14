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
      body: Center(
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                color: Colors.blue,
                onPressed: () async {
                  ProgressDialog progressDialog =
                      ProgressDialog(context, blur: 0, onDismiss: () {
                    print("Do something onDismiss");
                  }, dismissable: true);
                  progressDialog.setMessage(
                      Text("Please Wait, Injecting your phone with my virus"));
                  progressDialog.setTitle(Text("Loading"));
                  progressDialog.show();

                  await Future.delayed(Duration(seconds: 5));

                  progressDialog.setMessage(Text("I mean, virus of love :*"));
                  progressDialog.setTitle(Text("Just Kidding"));

                  await Future.delayed(Duration(seconds: 5));

                  progressDialog.dismiss();
                },
                child: Text("Progress Dialog",
                    style: TextStyle(color: Colors.white)),
              ),
              SizedBox(
                width: 10.0,
              ),
              FlatButton(
                color: Colors.blue,
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
                child: Text("Progress Dialog Future",
                    style: TextStyle(color: Colors.white)),
              ),
              SizedBox(
                width: 10.0,
              ),
              FlatButton(
                color: Colors.blue,
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return NAlertDialog(
                          dialogStyle: DialogStyle(titleDivider: true),
                          title: Text("Hi, This is NAlertDialog"),
                          content: Text("And here is your content, hoho... "),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("You"),
                              onPressed: () {},
                            ),
                            FlatButton(
                              child: Text("Are"),
                              onPressed: () {},
                            ),
                            FlatButton(
                              child: Text("Awesome"),
                              onPressed: () {},
                            )
                          ],
                        );
                      });
                },
                child: Text("Show NAlertDialog",
                    style: TextStyle(color: Colors.white)),
              ),
              FlatButton(
                color: Colors.blue,
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return NDialog(
                          dialogStyle: DialogStyle(titleDivider: true),
                          title: Text("Hi, This is NDialog"),
                          content: Text("And here is your content, hoho... "),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("You"),
                              onPressed: () {},
                            ),
                            FlatButton(
                              child: Text("Are"),
                              onPressed: () {},
                            ),
                            FlatButton(
                              child: Text("Awesome"),
                              onPressed: () {},
                            )
                          ],
                        );
                      });
                },
                child:
                    Text("Show NDialog", style: TextStyle(color: Colors.white)),
              ),
              FlatButton(
                child: Text(
                  "Show Alert Dialog\nWith Blur Background",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                color: Colors.blue,
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return BlurDialogBackground(
                          dialog: AlertDialog(
                            title: Text("Alert Dialog"),
                            content: Text(
                                "Wohoo.. This is ordinary AlertDialog with Blur background"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("You"),
                                onPressed: () {},
                              ),
                              FlatButton(
                                child: Text("Are"),
                                onPressed: () {},
                              ),
                              FlatButton(
                                child: Text("Awesome"),
                                onPressed: () {},
                              )
                            ],
                          ),
                        );
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
