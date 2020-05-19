# NDialog 
[![Fork](https://img.shields.io/github/forks/nizwar/ndialog?style=social)](https://github.com/nizwar/ndialog/fork)&nbsp; [![Star](https://img.shields.io/github/stars/nizwar/ndialog?style=social)](https://github.com/nizwar/ndialog/star)&nbsp; [![Watches](https://img.shields.io/github/watchers/nizwar/ndialog?style=social)](https://github.com/nizwar/ndialog/)&nbsp; [![Get the library](https://img.shields.io/badge/Get%20library-pub-blue)](https://pub.dev/packages/ndialog)&nbsp; [![Example](https://img.shields.io/badge/Example-Ex-success)](https://pub.dev/packages/ndialog#-example-tab-)

Custom dialog with blur background and popup animation and ProgressDialog with native style.

## Let's Code!

This library have 2 Dialog : NDialog and ProgressDialog, you can Custom your dialog with blur background using BlurDialogBackground

### NAlertDialog & NDialog 

I separate the NDialog class into 2, that is NAlertDialog (NDialog like before) and NDialog (Raw Dialog without blur)

#### NAlertDialog

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
  }
);
```

#### NDialog

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

### ProgressDialog

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

### BlurDialogBackground

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

That's it, have fun 😀

## Screenshot

<p align="center">
  <a href="https://1.bp.blogspot.com/-x9i-ZikgprA/XZRHrF1AP5I/AAAAAAAAGyc/ZqqSsHN-_aUOscsTUqn8-I3V6OwBWJDBwCLcBGAsYHQ/s2000/Screenshot_20191002_134440%255B1%255D.jpg"> <img src="https://1.bp.blogspot.com/-x9i-ZikgprA/XZRHrF1AP5I/AAAAAAAAGyc/ZqqSsHN-_aUOscsTUqn8-I3V6OwBWJDBwCLcBGAsYHQ/s320/Screenshot_20191002_134440%255B1%255D.jpg"/></a> 
  <a href="https://1.bp.blogspot.com/-8ybIrlaNxeA/XZrBLCTxE6I/AAAAAAAAGzA/CpRWabOtuTAibsXhu_Oi8ZzjJIQo18X1wCLcBGAsYHQ/s2000/Screenshot_20191007_113509.jpg"> <img src="https://1.bp.blogspot.com/-8ybIrlaNxeA/XZrBLCTxE6I/AAAAAAAAGzA/CpRWabOtuTAibsXhu_Oi8ZzjJIQo18X1wCLcBGAsYHQ/s320/Screenshot_20191007_113509.jpg"/></a>
</p>  

