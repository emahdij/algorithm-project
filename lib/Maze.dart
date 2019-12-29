import 'dart:math';

class Maze {
  var lst = new List<List<int>>.generate(
      20, (i) => List<int>.generate(20, (j) => i * 20 + j));
  Maze(int blacks) {
    initial(blacks);
  }

  void initial(int black) {
    for (var i = 0; i < 20; i++) {
      for (var j = 0; j < 20; j++) {
        lst[i][j] = 0;
      }
    }
    var rand = new Random();
    int i = 0;
    int temptand;
    int xindex;
    int yindex;
    //initializing walls
    while (i < black) {
      temptand = rand.nextInt(400);
      xindex = temptand % 20;
      yindex = ((temptand - xindex) / 20).round();
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
      if (lst[yindex][xindex] == 0) sw = false;
    }
    lst[yindex][xindex] = 10;
    //initializing target point
    sw = true;
    while (sw) {
      temptand = rand.nextInt(400);
      xindex = temptand % 20;
      yindex = ((temptand - xindex) / 20).round();
      if (lst[yindex][xindex] == 0) sw = false;
    }
    lst[yindex][xindex] = 20;
  }

  List getList() {
    return lst;
  }
}
