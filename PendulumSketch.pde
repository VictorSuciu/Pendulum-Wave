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
int fps = 30;
float k;
boolean doneBuildingUI = false;
Wave pendWave;

//GUI
ControlP5 cp5;

int sliderW = 150;
int sliderH = 30;
int txtW = 40;
int txtH = sliderH;
int insetTxt = 10;
int inset = insetTxt + txtW;
int insetV = 40;
int updateW = 140;
int updateH = 50;
int topY = 40;
int uiEndConst = insetTxt + txtW + sliderW + 10;

void settings() {
  //size(winW, winH);
  fullScreen();
}
void setup() {
  
  background(50);
  frameRate(fps);
  pivot = new Point(uiEndConst + ((width - uiEndConst) / 2.0), 20);
  maxLen = min(((width - uiEndConst) / 2) - 15, height - 15);
  pendWave = new Wave(numPends, timeRep, maxLen, pivot, deg, pendBetween, fps);
  
  
  buildUI();
  doneBuildingUI = true;
}

void buildUI() {
  cp5 = new ControlP5(this);
  
  
  PFont font = createFont("arial", 11);
  cp5.setFont(font);
  println("PENDBETWEEN = " + pendBetween);
  cp5.addSlider("pendBetweenS")
     .setPosition(inset, topY + (0 * (sliderH + insetV)))
     .setSize(sliderW, sliderH)
     .setRange(0, numPends / 2)
     .setNumberOfTickMarks(numPends / 2 + 1)
     .snapToTickMarks(true)
     .showTickMarks(false)
     .setValue(pendBetween)
     .setLabel("");
  cp5.addTextfield("lineBetweenTxt")
     .setSize(txtW, txtH)
     .setPosition(insetTxt, topY + (0 * (sliderH + insetV)))
     .setLabel("Line Between Every ___ \nPendulums");
     
  cp5.addSlider("degS")
     .setPosition(inset, topY + (2 * (sliderH + insetV)))
     .setSize(sliderW, sliderH)
     .setRange(0, 90)
     .setNumberOfTickMarks(91)
     .snapToTickMarks(true)
     .showTickMarks(false)
     .linebreak()
     .setValue(deg)
     .setLabel("");
  cp5.addTextfield("degTxt")
     .setSize(txtW, txtH)
     .setPosition(insetTxt, topY + (2 * (sliderH + insetV)))
     .setLabel("Swing Angle");
     
  cp5.addSlider("numPendsS")
     .setPosition(inset, topY + (3 * (sliderH + insetV)))
     .setSize(sliderW, sliderH)
     .setRange(1, 200)
     .setNumberOfTickMarks(200)
     .snapToTickMarks(true)
     .showTickMarks(false)
     .setValue(numPends)
     .setLabel("");
  cp5.addTextfield("numPendsTxt")
     .setSize(txtW, txtH)
     .setPosition(insetTxt, topY + (3 * (sliderH + insetV)))
     .setLabel("Number of Pendulums");  
  
     
  cp5.addSlider("gravConstS")
     .setPosition(inset, topY + (4 * (sliderH + insetV)))
     .setSize(sliderW, sliderH)
     .setRange(0, 50)
     .setValue(gravConst)
     .setLabel("");
  cp5.addTextfield("gravConstTxt")
     .setSize(txtW, txtH)
     .setPosition(insetTxt, topY + (4 * (sliderH + insetV)))
     .setLabel("Gravity (m/s/s)");
     
  cp5.addSlider("timeRepS")
     .setPosition(inset, topY + (5 * (sliderH + insetV)))
     .setSize(sliderW, sliderH)
     .setRange(1, 500)
     .setNumberOfTickMarks(500)
     .snapToTickMarks(true)
     .showTickMarks(false)
     .setValue(timeRep)
     .setLabel("");
  cp5.addTextfield("timeRepTxt")
     .setSize(txtW, txtH)
     .setPosition(insetTxt, topY + (5 * (sliderH + insetV)))
     .setLabel("Wave Cycle Period (seconds)");
     
  cp5.addSlider("maxLenS")
     .setPosition(inset, topY + (6 * (sliderH + insetV)))
     .setSize(sliderW, sliderH)
     .setRange(0, 1000)
     .setNumberOfTickMarks(1001)
     .snapToTickMarks(true)
     .showTickMarks(false)
     .setValue(maxLen)
     .setLabel("");
  cp5.addTextfield("maxLenTxt")
     .setSize(txtW, txtH)
     .setPosition(insetTxt, topY + (6 * (sliderH + insetV)))
     .setLabel("Longest Pendulum Length");
     
  cp5.addButton("Update and Reset")
     .setPosition(insetTxt + ((sliderW + txtW) / 2) - (updateW / 2), topY + (7 * (sliderH + insetV)))
     .setSize(updateW, updateH);
   
}

public void controlEvent(ControlEvent e) {
  if(e.getController().getName().equals("Update and Reset")) {
    
    maxLen = cp5.getController("maxLenS").getValue();
    timeRep = cp5.getController("timeRepS").getValue();
    numPends = (int)cp5.getController("numPendsS").getValue();
    pendBetween = (int)cp5.getController("pendBetweenS").getValue();
    deg = (int)cp5.getController("degS").getValue();
    gravConst = cp5.getController("gravConstS").getValue();
    
    pendWave.reset(numPends, timeRep, maxLen, pivot, deg, pendBetween, fps);
    
    ((Slider)cp5.getController("pendBetweenS")).setRange(0, numPends / 2)
                                                         .setNumberOfTickMarks(numPends / 2 + 1)
                                                         //.snapToTickMarks(true)
                                                         .showTickMarks(false);
  }
  else if(e.getController().getName().equals("pendBetweenS") && doneBuildingUI) {
    println("PENDBETWEEN = " + pendBetween);
    pendBetween = (int)((Slider)cp5.getController("pendBetweenS")).getValue();
    //((Textfield)cp5.getController("pendBetweenTxt")).setValue(pendBetween);
    
  }
  else if(e.getController().getName().charAt(e.getController().getName().length() - 1) == 'S' && doneBuildingUI) {
    println("UPDATING TXT");
    ((Textfield)cp5.getController(e.getController()
                       .getName()
                       .substring(0, e.getController()
                                      .getName()
                                      .length() - 1) 
                                 + "Txt"))
       .setText("" + ((Slider)e.getController()).getValue());
       
       ((Textfield)cp5.getController(e.getController()
                       .getName()
                       .substring(0, e.getController()
                                      .getName()
                                      .length() - 1) 
                                 + "Txt"))
       .update();
       
       println(e.getController()
                       .getName()
                       .substring(0, e.getController()
                                      .getName()
                                      .length() - 1) 
                                 + "Txt");
  }
  
}

void draw() {
  clear();
  background(50);
  
  pendWave.update(pendBetween);
  fill(30, 30, 30, 127);
  //tint(0x151515, 75);
  rect(0, 0, uiEndConst, height); 
  //noTint();
  //p1.updatePosition();
  //p2.updatePosition();
}
