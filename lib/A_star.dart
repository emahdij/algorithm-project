import 'dart:collection';
import 'dart:math';

import 'package:ai_p/Cell.dart';

class Astar {
  List lst = new List<List<int>>.generate(
      20, (i) => List<int>.generate(20, (j) => i * 20 + j));
  List visited = new List<List<bool>>.generate(
      20, (i) => List<bool>.generate(20, (j) => false));
  Cell start;
  Cell target;
  int cost = null;
  int expanded = null;
  List<Cell> path = new List<Cell>();
  List<Cell> open_list = new List<Cell>();
  List<Cell> close_list = new List<Cell>();
  Astar(List lst, Cell start, Cell target) {
    this.lst = lst;
    this.start = Cell.distance(start.getY(), start.getX(), null);
    this.start.setFcost(0);
    this.start.setGcost(0);
    this.start.setHcost(0);
    this.target = Cell.distance(target.getY(), target.getX(), null);
    this.target.setFcost(0);
    this.target.setGcost(0);
    this.target.setHcost(0);
  }

  int search() {
    expanded = 1;
    open_list.add(start);
    while (open_list.length > 0) {
      Cell current_node = open_list[0];
      int current_index = 0;

      for (int i = 0; i < open_list.length; i++) {
        if (open_list[i].getFcost() < current_node.getFcost()) {
          current_node = open_list[i];
          current_index = i;
        }
      }
      visited[current_node.getY()][current_node.getX()] = true;
      open_list.removeAt(current_index);
      close_list.add(current_node);
      if (current_node.getX() == target.getX() &&
          current_node.getY() == target.getY()) {
        Cell current = current_node;
        while (current != null) {
          path.add(current);
          current = current.getParent();
        }
        return current_node.getGcost();
      }
      List<Cell> neighbours = new List<Cell>();
      neighbours = getNeighbours(current_node);
      for (var neighbour in neighbours) {
        neighbour.setGcost(current_node.getGcost() + 1);
        neighbour.setHcost(pow(neighbour.getX() - target.getX(), 2) +
            pow(neighbour.getY() - target.getY(), 2));
        neighbour.setFcost(neighbour.getGcost() + neighbour.getHcost());
        for (var open in open_list)
          if (neighbour.getX() == open.getX() &&
              neighbour.getY() == open.getY() &&
              neighbour.getGcost() > open.getGcost()) continue;
        expanded++;
        open_list.add(neighbour);
      }
    }
    return null;
  }

  List getNeighbours(Cell cell) {
    List<Cell> tmp = new List();
    int x = cell.getX();
    int y = cell.getY();
    if (!(x + 1 > 19)) if (!visited[y][x + 1]) if (lst[y][x + 1] != 1)
      tmp.add(new Cell.distance(y, x + 1, cell));
    if (!(y + 1 > 19)) if (!visited[y + 1][x]) if (lst[y + 1][x] != 1)
      tmp.add(new Cell.distance(y + 1, x, cell));
    if (!(x - 1 < 0)) if (!visited[y][x - 1]) if (lst[y][x - 1] != 1)
      tmp.add(new Cell.distance(y, x - 1, cell));
    if (!(y - 1 < 0)) if (!visited[y - 1][x]) if (lst[y - 1][x] != 1)
      tmp.add(new Cell.distance(y - 1, x, cell));
    return tmp;
  }

  List<Cell> getPath() {
    return path;
  }

  int getExpanded() {
    return expanded;
  }
}
