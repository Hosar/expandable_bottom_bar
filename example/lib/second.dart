import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Image.network(
                'https://www.mascotarios.org/wp-content/gallery/sanbernardo/sanbernardo9.jpg'),
            Container(
              child: Text('Description', style: TextStyle(fontSize: 40)),
            ),
            RaisedButton(
              child: Text('Press'),
              onPressed: () {
                print('done');
              },
            )
          ],
        ),
      ),
    );
  }
}