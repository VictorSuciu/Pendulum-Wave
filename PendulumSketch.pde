import controlP5.*;
static float gravConst = 5;

final int winW = 1150;
final int winH = 700;
Point pivot;
float maxLen;
float timeRep = 70;
int numPends = 20;
int pendBetween = 0;
int deg = 40;
float k;
boolean doneBuildingUI = false;
Wave pendWave;

ControlP5 cp5;
//Slider angleSlide;
//Slider numPendSlide;
//Slider gravSlide;
//Slider timeSlide;
//Slider lengthSlide;


void settings() {
  //size(winW, winH);
  fullScreen();
}
void setup() {
  
  background(50);
  frameRate(30);
  pivot = new Point(width / 2.0, 20);
  maxLen = min((width / 2) - 10, height - 10);
  pendWave = new Wave(numPends, timeRep, maxLen, pivot, deg, pendBetween);
  
  
  buildUI();
  doneBuildingUI = true;
}

void buildUI() {
  cp5 = new ControlP5(this);
  int sliderW = 150;
  int sliderH = 30;
  int inset = 10;
  int insetV = 10;
  int updateW = 140;
  int updateH = 50;
  int topY = 40;
  
  println("PENDBETWEEN = " + pendBetween);
  cp5.addSlider("Line Between Every ___")
     .setPosition(inset, topY + (0 * (sliderH + insetV)))
     .setSize(sliderW, sliderH)
     .setRange(0, numPends / 2)
     .setNumberOfTickMarks(numPends / 2 + 1)
     .snapToTickMarks(true)
     .showTickMarks(false)
     .setValue(pendBetween);
     
  cp5.addSlider("Swing Angle")
     .setPosition(inset, topY + (2 * (sliderH + insetV)))
     .setSize(sliderW, sliderH)
     .setRange(0, 90)
     .setNumberOfTickMarks(91)
     .snapToTickMarks(true)
     .showTickMarks(false)
     .linebreak()
     .setValue(deg);
     
  cp5.addSlider("Number of Pendulums")
     .setPosition(inset, topY + (3 * (sliderH + insetV)))
     .setSize(sliderW, sliderH)
     .setRange(1, 200)
     .setNumberOfTickMarks(200)
     .snapToTickMarks(true)
     .showTickMarks(false)
     .setValue(numPends);
     
  
     
  cp5.addSlider("Grvitaty (m/s/s)")
     .setPosition(inset, topY + (4 * (sliderH + insetV)))
     .setSize(sliderW, sliderH)
     .setRange(0, 50)
     .setValue(gravConst);
     
  cp5.addSlider("Time Period")
     .setPosition(inset, topY + (5 * (sliderH + insetV)))
     .setSize(sliderW, sliderH)
     .setRange(1, 500)
     .setNumberOfTickMarks(500)
     .snapToTickMarks(true)
     .showTickMarks(false)
     .setValue(timeRep);
     
  cp5.addSlider("Longest Pendulum Length")
     .setPosition(inset, topY + (6 * (sliderH + insetV)))
     .setSize(sliderW, sliderH)
     .setRange(0, 1000)
     .setNumberOfTickMarks(1001)
     .snapToTickMarks(true)
     .showTickMarks(false)
     .setValue(maxLen);
     
  cp5.addButton("Update and Reset")
     .setPosition(inset - (updateW / 2) + (sliderW / 2), topY + (7 * (sliderH + insetV)))
     .setSize(updateW, updateH);
   
}

public void controlEvent(ControlEvent e) {
  if(e.getController().getName().equals("Update and Reset")) {
    
    maxLen = cp5.getController("Longest Pendulum Length").getValue();
    timeRep = cp5.getController("Time Period").getValue();
    numPends = (int)cp5.getController("Number of Pendulums").getValue();
    pendBetween = (int)cp5.getController("Line Between Every ___").getValue();
    deg = (int)cp5.getController("Swing Angle").getValue();
    gravConst = cp5.getController("Grvitaty (m/s/s)").getValue();
    
    println("BUTTON PRESSED");
    pendWave.reset(numPends, timeRep, maxLen, pivot, deg, pendBetween);
    
    ((Slider)cp5.getController("Line Between Every ___")).setRange(0, numPends / 2)
                                                         .setNumberOfTickMarks(numPends / 2 + 1)
                                                         //.snapToTickMarks(true)
                                                         .showTickMarks(false);
  }
  else if(e.getController().getName().equals("Line Between Every ___") && doneBuildingUI) {
    pendBetween = (int)cp5.getController("Line Between Every ___").getValue();
    println("PENDBETWEEN = " + pendBetween);
  }
}

void draw() {
  clear();
  background(50);
  
  pendWave.update(pendBetween);
  
  //p1.updatePosition();
  //p2.updatePosition();
}
