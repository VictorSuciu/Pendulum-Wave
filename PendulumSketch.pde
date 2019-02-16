
static final float GRAV_CONST = 5;
Point pivot = new Point(700, 0);
float maxLen = 700;
float timeRep = 60;
int numPends = 20;
float k;

Wave pendWave;

void setup() {
  size(1400, 900);
  background(50);
  frameRate(30);
  
  pendWave = new Wave(numPends, timeRep, maxLen, pivot, 40, 2);
  
  //angle slider
  //num pendulums slider
  //gravity slider
  //time peperiod slider
  //max lenght slider
  
}



void draw() {
  clear();
  background(50);
  
  pendWave.update();
  
  //p1.updatePosition();
  //p2.updatePosition();
}
