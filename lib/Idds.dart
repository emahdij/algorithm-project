import 'dart:collection';

import 'package:ai_p/Cell.dart';

class Idds {
  List lst = new List<List<int>>.generate(
      20, (i) => List<int>.generate(20, (j) => i * 20 + j));
  List visited = new List<List<bool>>.generate(
      20, (i) => List<bool>.generate(20, (j) => false));
  List<List<Cell>> prev = new List<List<Cell>>.generate(
      20, (i) => List<Cell>.generate(20, (j) => null));
  List<Cell> path = new List<Cell>();
  Cell start;
  Cell target;
  int cost = null;
  int expanded = null;
  int depth = null;
  int level;
  Idds(List lst, Cell start, Cell target) {
    this.lst = lst;
    this.start = Cell.level(start.getY(), start.getX(), 0);
    this.target = target;
  }

  int search() {
    this.expanded = 1;
    for (var i = 0; i < 100; i++) {
      visited = new List<List<bool>>.generate(
          20, (i) => List<bool>.generate(20, (j) => false));
      if (find(start, i) == true) {
        depth = i;
        break;
      }
    }
    return pathCompu();
  }

  bool find(Cell node, int level) {
    this.expanded++;
    visited[node.getY()][node.getX()] = true;
    if (node.getX() == target.getX() && node.getY() == target.getY())
      return true;
    List<Cell> neighbours;
    neighbours = getNeighbours(node);
    if (node.getLevel() + 1 <= level) {
      for (var next in neighbours) {
        bool result;
        prev[next.getY()][next.getX()] = node;
        result = find(
            new Cell.level(next.getY(), next.getX(), node.getLevel() + 1),
            level);
        if (result == true) return true;
      }
    }
    return false;
  }

  List getNeighbours(Cell cell) {
    List<Cell> tmp = new List();
    int x = cell.getX();
    int y = cell.getY();
    if (!(x + 1 > 19)) if (!visited[y][x + 1]) if (lst[y][x + 1] != 1)
      tmp.add(new Cell(y, x + 1));
    if (!(y + 1 > 19)) if (!visited[y + 1][x]) if (lst[y + 1][x] != 1)
      tmp.add(new Cell(y + 1, x));
    if (!(x - 1 < 0)) if (!visited[y][x - 1]) if (lst[y][x - 1] != 1)
      tmp.add(new Cell(y, x - 1));
    if (!(y - 1 < 0)) if (!visited[y - 1][x]) if (lst[y - 1][x] != 1)
      tmp.add(new Cell(y - 1, x));
    return tmp;
  }

  int pathCompu() {
    int tmp = 0;
    for (Cell current = target;
        current != null;
        current = prev[current.getY()][current.getX()]) {
      tmp++;
      path.add(current);
    }

    setCost(tmp);
    if (path[path.length - 1].getX() == start.getX() &&
        path[path.length - 1].getY() == start.getY())
      return cost;
    else
      return null;
  }

  int getCost() {
    return cost;
  }

  void setCost(int cost) {
    this.cost = cost;
  }

  List getPath() {
    return path;
  }

  int getExpanded() {
    return expanded;
  }

  int getDepth() {
    return depth;
  }
}
