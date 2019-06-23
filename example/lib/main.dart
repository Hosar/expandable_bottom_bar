import './second.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:expandable_app_bottom_bar/expandable_bottom_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => MyHomePage(title: 'Demo'),
        '/second': (BuildContext context) => SecondPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.pink,
      ),
      body: Container(
        color: Colors.white24,
      ),
      bottomNavigationBar: ExpandableBottomBar(
        autoHide: true,
        stopOnDrag: false,
        child: SomeImage(),
        color: Colors.green,
        barButtons: Container(
          color: Colors.pink,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  print('onPressed <-');
                },
                child: Icon(Icons.arrow_back),
              ),
              FlatButton(
                child: Icon(Icons.arrow_forward),
                onPressed: () {
                  print('onPressed ->');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SomeImage extends StatelessWidget {
  const SomeImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow[400],
      child: Column(
        children: <Widget>[
          Container(
            constraints: BoxConstraints(maxHeight: 200),
            child: Image.network(
                'https://www.mascotarios.org/wp-content/gallery/sanbernardo/sanbernardo9.jpg'),
          ),
          Container(
            child: Text('Main content', style: TextStyle(fontSize: 40)),
          ),
          RaisedButton(
            child: Text('Press'),
            onPressed: () {
              print('done');
            },
          )
        ],
      ),
    );
  }
}

class SomeImage2 extends StatelessWidget {
  const SomeImage2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
      ),
      body: Image.network(
          'https://www.mascotarios.org/wp-content/gallery/sanbernardo/sanbernardo9.jpg'),
    );
  }
}
