# Example
This library have 2 Dialog : NDialog and ProgressDialog

## NAlertDialog & NDialog

I separate the NDialog class into 2, that is NAlertDialog (NDialog like before) and NDialog (Raw Dialog without blur)

### NAlertDialog

Dialog that will show using blur background, you can custom it easily.

``` dart
await showDialog(
  context: context,
  builder: (context) {
    return NAlertDialog(
      dialogStyle: DialogStyle(
      onDismiss: () {},
      dismissable: true,
      titleDivider: true),
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
  }
);
```

Psttt i got you a simple way to show NAlertDialog

``` dart
  NAlertDialog(
    title: Text("Woooaaahhh"),
    content: Text("It so fun!"),
  ).show(context);
```

### NDialog

Raw dialog that you can use directly to showDialog without Blur Background

``` dart
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
  }
);
```

Of course NDialog can do it too!
``` dart
  NDialog(
    title: Text("Woho"),
    content: Text("I'm a simple NDialog to show!"),
  ).show(context);
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

## BlurDialogBackground

Now you can blur any dialog, simply wrap them with BlurDialogBackground

``` dart
await showDialog(
  context: context,
  builder: (context) {
    return BlurDialogBackground(
      dialog: AlertDialog(
        title: Text("Alert Dialog"),
        content: Text("Wohoo.. This is ordinary AlertDialog with Blur background"),
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
  }
);
```

