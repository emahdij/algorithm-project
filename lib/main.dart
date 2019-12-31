import 'dart:html';
import 'package:ai_p/Bfs.dart';
import 'package:ai_p/Cell.dart';
import 'package:ai_p/Ids.dart';
import 'package:ai_p/Maze.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

enum Algorithm { BFS, IDS, Astar }
List<Cell> path = new List<Cell>();
Maze maze;
int cost = null;
int sw = 0;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    maze = new Maze(120);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Maze',
        home: Container(
          child: Table(),
        ));
  }
}

class Table extends StatefulWidget {
  Table({Key key}) : super(key: key);
  @override
  createState() => _TableState();
}

class _TableState extends State<Table> {
  @override
  Widget build(BuildContext context) {
    if (sw == 0) Future.delayed(Duration.zero, () => showAlert(context));
    return MaterialApp(
      title: 'Maze',
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey,
        ),
        child: GridView.count(
          childAspectRatio: (2 / 1),
          crossAxisCount: 20,
          mainAxisSpacing: 1.1,
          crossAxisSpacing: 1.1,
          padding: EdgeInsets.all(6),
          children: List.generate(400, (index) {
            int xindex = index % 20;
            int yindex = ((index - xindex) / 20).round();
            Color color;
            Icon icon;
            bool swbut = false;
            for (var item in path) {
              if (item.getX() == xindex && item.getY() == yindex) {
                if (sw == 1)
                  icon = Icon(
                    Icons.accessible_forward,
                    color: Colors.black87,
                  );
                else if (sw == 2)
                  icon = Icon(
                    Icons.airport_shuttle,
                    color: Colors.black87,
                  );
                else if (sw == 3)
                  icon = Icon(
                    Icons.airplanemode_active,
                    color: Colors.black87,
                  );
                swbut = true;
                break;
              }
            }

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

  void bfs_search() {
    sw = 1;
    Bfs bfs = new Bfs(maze.getList(), maze.getStart(), maze.getTarget());
    cost = bfs.search();
    if (cost != null) setState(() => path = bfs.getPath());
  }

  void ids_search() {
    sw = 2;
    Ids ids = new Ids(maze.getList(), maze.getStart(), maze.getTarget());
    cost = ids.search();
    if (cost != null) setState(() => path = ids.getPath());
  }

  void showAlert(BuildContext context) async {
    showDialog<Algorithm>(
        context: context,
        barrierDismissible: true,
        builder: (context) => SimpleDialog(
              title: const Text('Select Algorithm!'),
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, Algorithm.BFS);
                    bfs_search();
                  },
                  child: const Text('BFS'),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, Algorithm.IDS);
                    ids_search();
                  },
                  child: const Text('IDS'),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, Algorithm.Astar);
                  },
                  child: const Text('A*'),
                ),
              ],
            ));
  }
}
