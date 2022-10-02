
### NDialog
Is a raw dialog where you can view them right away without anything else

``` dart
  NDialog(
    dialogStyle: DialogStyle(titleDivider: true),
    title: Text("NDialog"),
    content: Text("This is NDialog's content"),
    actions: <Widget>[
      TextButton(child: Text("Okay"), onPressed: () => Navigator.pop(context)),
      TextButton(child: Text("Close"), onPressed: () => Navigator.pop(context)),
    ],
  ).show(context);
```

### NAlertDialog
Is a dialog where you can directly set the background attributes without be wrapped by `DialogBackground` and you can simply display them.

``` dart
  NAlertDialog(
    dialogStyle: DialogStyle(titleDivider: true),
    title: Text("NAlertDialog"),
    content: Text("This is NAlertDialog's content"),
    actions: <Widget>[
      TextButton(child: Text("Okay"), onPressed: () => Navigator.pop(context)),
      TextButton(child: Text("Close"), onPressed: () => Navigator.pop(context)),
    ],
  ).show(context);
``` 

### ZoomDialog
Is a dialog that you can zoom on it, you can zoom all type of widget on this dialog, simplye write this code and boom, there you go!

``` dart
  ZoomDialog(
    zoomScale: 5,
    child: Container(
      child: Text("Zoom me!"),
      color: Colors.white,
      padding: EdgeInsets.all(20),
    ),
  ).show(context);
```  

### ProgressDialog
Will display the ProgressDialog with Android native style.

``` dart
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
  progressDialog.setLoadingWidget(CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.red)));
  progressDialog.setTitle(Text("ProgressDialog Title changed"));
  progressDialog.setMessage(Text("It will change again after 5 seconds"));

  //Show dialog
  progressDialog.show();

  //After 5 seconds, change the title, message and loading widget to null (default widget is CircularProgressIndicator)
  await Future.delayed(Duration(seconds: 5));
  progressDialog.setLoadingWidget(null);
  progressDialog.setMessage(Text("ProgressDialog will dismiss after 5 seconds"));
  progressDialog.setTitle(Text("Last changes"));

  //After 5 seconds, dismiss the dialog
  await Future.delayed(Duration(seconds: 5));
  progressDialog.dismiss();
```

### CustomProgressDialog
Will display a progress dialog with customizable widgets

``` dart
  CustomProgressDialog progressDialog = CustomProgressDialog(
    context,
    blur: 10,
    onDismiss: () => print("Do something onDismiss"),
  );
  //Set loading with red circular progress indicator
  progressDialog.setLoadingWidget(CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.red)));

  //Show dialog
  progressDialog.show();

  //After 5 seconds, change the loading widget to null (default widget is CircularProgressIndicator)
  await Future.delayed(Duration(seconds: 5));
  progressDialog.setLoadingWidget(null);

  //After 5 seconds, dismiss the dialog
  await Future.delayed(Duration(seconds: 5));
  progressDialog.dismiss();
```

### Show Progress Dialog Once with .future()
This is what I'm talking about, Each Progress Dialog has a `.future(context)` static function, which will help you display the progress dialog once until `Future` is completed!

```dart
  ///ProgressDialog
  ProgressDialog.future(
    context,
    title: Text("ProgressDialog.future()"),
    message: Text("This will finis after 5 seconds"),
    future: Future.delayed(Duration(seconds: 5), () => "The end of future (5 seconds)"),
    onProgressError: (error) => print("Do something onProgressError"),
    onProgressFinish: (data) => print("Do something onProgressFinish"),
    onDismiss: () => print("Dismissed"),
  ).then((value) => print(value));

  ///CustomProgressDialog
  CustomProgressDialog.future(
    context,
    future: Future.delayed(Duration(seconds: 5), () => "The end of future (5 seconds)"),
    onProgressError: (error) => print("Do something onProgressError"),
    onProgressFinish: (data) => print("Do something onProgressFinish"),
    onDismiss: () => print("Dismissed"),
  ).then((value) => print(value));

```

## Future Extensions
Now you can show a dialog on every futures by simply add a single code.

``` dart
  //Make sure you import ndialog to call extensions function
  import 'package:ndialog/ndialog.dart';

  ...
  Future.delayed(Duration(seconds: 3)).showProgressDialog(
    context,
    title: Text("Title of ProgressDialog"),
    message: Text("This dialog will be close after 3 seconds"),
  );
  //or
  Future.delayed(Duration(seconds:3)).showCustomProgressDialog(context);
```

## Dialog Extensions!
You can simply call `show(context)` at the end of Flutter's built-in dialogs.

```dart
  //Make sure you import ndialog to call extensions function
  import 'package:ndialog/ndialog.dart';

  ...

  AlertDialog( ... ).show(context);
  SimpleDialog( ... ).show(context);
  Dialog( ... ).show(context);
  CupertinoAlertDialog( ... ).show(context);
```

## DialogBackground
You can use DialogBackground to create your own custom dialog and display them easily, you can also change the barrierColor / background color and add little bit blur effects there.

Note : BlurDialogBackground is depreceted, use `DialogBackground` instead!

``` dart
  DialogBackground(
    blur: 5,
    dialog: AlertDialog(
      title: Text("NAlert Dialog"),
      content: Text("NAlertDialog with Blur background"),
      actions: <Widget>[
        TextButton(child: Text("Okay"), onPressed: () => Navigator.pop(context)),
        TextButton(child: Text("Close"), onPressed: () => Navigator.pop(context)),
      ],
    ),
  ).show(context);
``` 
