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
          child: FlatButton(
        color: Colors.blue,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return NDialog(
                  blur: 5,
                  content:
                      Text("Hi, This is the content of dialog that you click."),
                  title: Text("NDialog"),
                  actions: <Widget>[
                    FlatButton(
                      padding: EdgeInsets.only(),
                      child: Text("You"),
                      onPressed: () {},
                    ),
                    FlatButton(
                      padding: EdgeInsets.only(),
                      child: Text("Are"),
                      onPressed: () {},
                    ),
                    FlatButton(
                      padding: EdgeInsets.only(),
                      child: Text("Awesome"),
                      onPressed: () {},
                    ),
                  ],
                );
              });
        },
        child: Text("Click Me :)", style: TextStyle(color: Colors.white)),
      )),
    );
  }
}
