import 'dart:math';

import 'package:ai_p/Bfs.dart';
import 'package:ai_p/Cell.dart';

class Maze {
  var lst =
      new List<List<int>>.generate(20, (i) => List<int>.generate(20, (j) => 0));
  Cell start;
  Cell target;
  int bfsCost;
  Maze(int blacks) {
    initial(blacks);
  }

  void initial(int black) {
    var rand = new Random();
    int i = 0;
    int temptand;
    int xindex;
    int yindex;
    //initializing walls
    while (i < black) {
      temptand = rand.nextInt(400);
      yindex = temptand % 20;
      xindex = ((temptand - yindex) / 20).round();
      if (lst[yindex][xindex] == 1) continue;
      lst[yindex][xindex] = 1;
      i++;
    }
    //initializing start point
    bool sw = true;
    while (sw) {
      temptand = rand.nextInt(400);
      xindex = temptand % 20;
      yindex = ((temptand - xindex) / 20).round();
      this.start = new Cell(yindex, xindex);
      if (lst[yindex][xindex] == 0) sw = false;
    }
    lst[yindex][xindex] = 10;
    //initializing target point
    sw = true;
    while (sw) {
      temptand = rand.nextInt(400);
      xindex = temptand % 20;
      yindex = ((temptand - yindex) / 20).round();
      this.target = new Cell(yindex, xindex);
      if (lst[yindex][xindex] == 0) sw = false;
    }
    lst[yindex][xindex] = 20;
  }

  Cell getStart() {
    return start;
  }

  Cell getTarget() {
    return target;
  }

  List getList() {
    return lst;
  }
}
