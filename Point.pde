public class Point {
  public float x;
  public float y;
  
  public Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
  public Point(Point other) {
    x = other.x;
    y = other.y;
  }
}
