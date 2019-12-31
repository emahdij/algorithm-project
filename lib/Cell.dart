class Cell {
  int x;
  int y;
  int level = null;
  Cell(int y, int x) {
    this.x = x;
    this.y = y;
  }
  Cell.level(int y, int x, int level) {
    this.x = x;
    this.y = y;
    this.level = level;
  }
  int getX() {
    return x;
  }

  int getY() {
    return y;
  }

  int getLevel() {
    return this.level;
  }
}
