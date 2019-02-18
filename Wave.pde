public class Wave {
  
  ArrayList<Pendulum> pendList = new ArrayList();
  private int numPends;
  private int lineSpace;
  private float timeRep;
  private float maxLen;
  private Point pivot;
  private float deg;
  private int armColor = 140;
  public Wave(int numPends, float timeRep, float maxLen, Point pivot, float deg, int lineSpace) {
    setValues(numPends, timeRep, maxLen, pivot, deg, lineSpace);
    
    populateList();
  }
  void setValues(int numPends, float timeRep, float maxLen, Point pivot, float deg, int lineSpace) {
    this.numPends = numPends;
    this.lineSpace = lineSpace;
    this.timeRep = timeRep;
    this.maxLen = maxLen;
    this.pivot = pivot;
    this.deg = deg;
  }
  private void populateList() {
    float on;
    float pendLen;
    for(int i = 0; i < numPends; i++) {
      k = (2 * PI * sqrt(maxLen / gravConst));
      on = ( (timeRep * 30) / (2.0 * PI * sqrt(maxLen / gravConst))) + i;
      pendLen = gravConst * pow((timeRep * 30) / ((2 * PI) * (on)) , 2);
      pendList.add(new Pendulum(pivot, pendLen, deg, numPends, i));
      //pendList.add(new Pendulum(pivot, 300 + (i * 20), 60, numPends, i));
    }
  }
  
  void update(int lineSpace) {
    for(int i = 0; i < numPends; i++) {
      pendList.get(i).updatePosition();
    }
    for(int i = 0; i < numPends; i++) {
      
      if(i < numPends - lineSpace) {
        stroke(armColor);
        strokeWeight(2);
        line(pendList.get(i).getBobX(), pendList.get(i).getBobY(),
             pendList.get(i + lineSpace).getBobX(), pendList.get(i + lineSpace).getBobY());
      }
      pendList.get(i).drawPendulum();
    }
  }
  void reset(int numPends, float timeRep, float maxLen, Point pivot, float deg, int lineSpace) {
    pendList.clear();
    setValues(numPends, timeRep, maxLen, pivot, deg, lineSpace);
    populateList();
    update(lineSpace);
  }
}
