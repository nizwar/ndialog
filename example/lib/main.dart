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
          child: Column(
        children: <Widget>[
          FlatButton(
            color: Colors.blue,
            onPressed: () async {
              ProgressDialog progressDialog = ProgressDialog(context,
                  dialogStyle: DialogStyle(onDismiss: () {
                print("Do something onDismiss");
              }));
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
            child:
                Text("Progress Dialog", style: TextStyle(color: Colors.white)),
          ),
          SizedBox(
            width: 10.0,
          ),
          FlatButton(
            color: Colors.blue,
            onPressed: () async {
              await ProgressDialog.future(context,
                  future: Future.delayed(Duration(seconds: 5)),
                  onProgressError: (error) {
                print("Do something onProgressError");
              }, onProgressFinish: (data) {
                print("Do something onProgressFinish");
              }, onProgressCancel: () {
                print("Do something onProgressCancel");
              },
                  message: Text("Please Wait"),
                  cancelText: Text("Batal"),
                  title: Text("Loging in"),
                  dialogStyle: DialogStyle(
                      onDismiss: () {
                        print("Do something onDismiss");
                      },
                      barrierDismissable: true));
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
                    return NDialog(
                      dialogStyle: DialogStyle(
                          onDismiss: () {}, barrierDismissable: true),
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
            child: Text("Show Dialog", style: TextStyle(color: Colors.white)),
          ),
        ],
      )),
    );
  }
}
