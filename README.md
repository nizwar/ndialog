# NDialog 
Custom dialog with blur background and popup animation, Made with love by [Moch. Nizwar Syafuan](https://fb.com/nizwar.richardo) ❤

## Let's Code!

``` dart
showDialog(
  context: context,
  builder: (context) {
    return NDialog(
      blur: 5,
      content: Text("Hi, This is the content of dialog that you click."),
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
  }
);
```
That's it, have fun 😀

## Screenshot
<p align="center">
  <a href="https://1.bp.blogspot.com/-x9i-ZikgprA/XZRHrF1AP5I/AAAAAAAAGyc/ZqqSsHN-_aUOscsTUqn8-I3V6OwBWJDBwCLcBGAsYHQ/s320/Screenshot_20191002_134440%255B1%255D.jpg"> <img src="https://1.bp.blogspot.com/-x9i-ZikgprA/XZRHrF1AP5I/AAAAAAAAGyc/ZqqSsHN-_aUOscsTUqn8-I3V6OwBWJDBwCLcBGAsYHQ/s200/Screenshot_20191002_134440%255B1%255D.jpg"/></a>  
</p>  

