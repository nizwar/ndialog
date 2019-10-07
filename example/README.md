# Example
This library have 2 Dialog : NDialog and ProgressDialog
Now you have to use DialogStyle to custom your dialog

## NDialog 

``` dart
await showDialog(
  context: context,
  builder: (context) {
    return NDialog(
      dialogStyle: DialogStyle(
        blur: 3,
        onDismiss: () {}, 
        barrierDismissable: true
      ),
      title: Text("Hi, This is NDialog"),
      content: Text("And here your content, hoho... "),
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
  }
);
```

## ProgressDialog

``` dart
ProgressDialog progressDialog = ProgressDialog(context, 
  message:Text("This is the message"), 
  title:Text("This is the title")
);

//You can set Message using this function
progressDialog.setTitle(Text("Loading"));
progressDialog.setMessage(Text("Please Wait, Injecting your phone with my virus"));

progressDialog.show();

await Future.delayed(Duration(seconds: 5));

//Progress Dialog already show? don't worry, you can change the message :D
progressDialog.setTitle(Text("Just Kidding"));
progressDialog.setMessage(Text("I mean, virus of love :*"));

await Future.delayed(Duration(seconds: 5));

progressDialog.dismiss();
```

Psstt...i make ProgressDialog realy fun...
Just using future, this function will show ProgressDialog until future (param) reach the end, you can handle the operation too!

``` dart
await ProgressDialog.future(context,
  future: Future.delayed(Duration(seconds: 5)),
  onProgressError: (error){
    //Error here
  },
  onProgressFinish: (data){
    //Everything setup
  },
  onProgressCancel: () {
    print("Do something onProgressCancel");
  },
  message: Text("Please Wait"),
  cancelText: Text("Batal"),
  title: Text("Waiting for delay"), 
  dialogStyle: DialogStyle(
    onDismiss: () {
      print("Do something onDismiss");
    },
    barrierDismissable: true
  )
);
```

