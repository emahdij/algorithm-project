import 'dart:collection';

import 'package:ai_p/Cell.dart';

class Bfs {
  List lst = new List<List<int>>.generate(
      20, (i) => List<int>.generate(20, (j) => i * 20 + j));
  List visited = new List<List<bool>>.generate(
      20, (i) => List<bool>.generate(20, (j) => false));
  List<List<Cell>> prev = new List<List<Cell>>.generate(
      20, (i) => List<Cell>.generate(20, (j) => null));
  List<Cell> path = new List<Cell>();
  Cell start;
  Cell target;
  Queue queue = new Queue();
  int cost = null;
  int expanded = null;
  Bfs(List lst, Cell start, Cell target) {
    this.lst = lst;
    this.start = start;
    this.target = target;
  }

  int search() {
    fillPrev();
    return pathCompu();
  }

  void fillPrev() {
    this.queue.add(start);
    visited[start.getY()][start.getX()] = true;
    Cell node;
    List<Cell> neighbours;
    this.expanded = 1;
    while (queue.isNotEmpty) {
      node = queue.removeFirst();
      neighbours = getNeighbours(node);
      for (var cell in neighbours) {
        this.expanded++;
        queue.add(cell);
        visited[cell.getY()][cell.getX()] = true;
        prev[cell.getY()][cell.getX()] = node;
        if (target.getX == cell.getX && target.getY == cell.getY) break;
      }
    }
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
  
}
