import 'dart:html';
import 'package:ai_p/Maze.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Maze maze = new Maze(40);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maze',
      home: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey,
        ),
        child: GridView.count(
          childAspectRatio: (2 / 1),
          crossAxisCount: 20,
          mainAxisSpacing: 1.1,
          crossAxisSpacing:1.1,
          padding: EdgeInsets.all(6),
          children: List.generate(400, (index) {
            int xindex = index % 20;
            int yindex = ((index - xindex) / 20).round();
            Color color;
            Icon icon;
            bool swbut = false;
            Text text = Text('');
            switch (maze.getList()[yindex][xindex]) {
              case 0:
                color = Colors.white;
                break;
              case 1:
                color = Colors.blueGrey;
                break;
              case 10:
                {
                  swbut = true;
                  color = Colors.green;
                  icon = Icon(
                    Icons.add_location,
                    color: Colors.black87,
                  );
                }
                break;
              case 20:
                {
                  swbut = true;
                  color = Colors.red;
                  icon = Icon(
                    Icons.adjust,
                    color: Colors.black87,
                  );
                }
                break;
            }
            return Container(
              decoration: BoxDecoration(
                color: color,
              ),
              child: swbut
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[icon],
                    )
                  : FlatButton(color: color, onPressed: () {}),
            );
          }),
        ),
      ),
    );
  }
}
