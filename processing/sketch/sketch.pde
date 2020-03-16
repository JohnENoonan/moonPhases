import processing.svg.*;

JSONArray days;
int size = 2000;
int numDays = 30;
int dayWidth = 100;
float moonSize = dayWidth *.5;

void setup(){
  // set processing parameters
  size(600,500);
  // set constants
  noLoop();
  days = loadJSONObject("../../data/phases.json").getJSONArray("data");
}


void draw(){
  for (int i = 0; i < numDays; i++){
    int x = i%6 * dayWidth;
    int y = i/6 * dayWidth;
    fill(((float)i/numDays)*255);
    pushMatrix();
    translate(x,y);
    drawDay(days.getJSONObject(i));
    popMatrix();
  }
}

void drawDay(JSONObject day){
  float illum = day.getFloat("illumination");
  rect(0,0,dayWidth,dayWidth);
  fill(255,0,0);
  ellipse(dayWidth/2,dayWidth/2,moonSize,moonSize);
}
