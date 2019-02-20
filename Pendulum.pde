public class Pendulum {
  private float gravConst = PendulumSketch.gravConst;
  private Point pivot;
  private float armLen;
  private float theta;
  private float startTheta;
  private float time;
  private float period;
  
  private float bobX;
  private float bobY;
  private int bobR;
  private int bobG;
  private int bobB;
  private float colorPeriod = 500;
  private float endConst = 3.0 / 5.0;
  public Pendulum(Point pivot, float armLen, float deg, int numPends, int index) {
    
    this.pivot = pivot;
    this.armLen = armLen;
    this.theta = deg * (PI / 180);
    this.startTheta = theta;
    period = (PI / 2) * sqrt(armLen / gravConst);
    time = 0;
    setColor(numPends, index);
  }
  private void setColor(int numPends, int index) {
    
    bobR = (int)(127.5 * (   cos( (  (index * ((float)colorPeriod / (float)numPends)) * endConst - (0) ) / ((float)colorPeriod / (2 * PI))   )   + 1));
    bobG = (int)(127.5 * (   cos( (  (index * ((float)colorPeriod / (float)numPends)) * endConst - ((float)colorPeriod/3.0)  ) / ((float)colorPeriod / (2 * PI))   )   + 1));
    bobB = (int)(127.5 * (   cos( (  (index * ((float)colorPeriod / (float)numPends)) * endConst - (2.0*(float)colorPeriod/3.0)  ) / ((float)colorPeriod / (2 * PI))   )   + 1));
    //println(index + " " + bobR + " " + bobG + " " + bobB);
}
  void updatePosition() {
    updateTime();
    theta = startTheta * cos(time / period);
    bobX = pivot.x + (armLen * -sin(theta));
    bobY = pivot.y + (armLen * cos(theta));
    //drawPendulum();
  }
  private void updateTime() {
    time = (time + (30.0 / fps)) % (period * (2 * PI));
  }
  void drawPendulum() {
    
    stroke(210);
    fill(bobR, bobG, bobB);
    
    strokeWeight(0);
    line( pivot.x, pivot.y, bobX, bobY);
    
    noStroke();
    ellipse(bobX, bobY, 25, 25);
  }
  float getBobX() {
    return bobX;
  }
  float getBobY() {
    return bobY;
  }
  
}
