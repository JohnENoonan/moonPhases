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
    fill(255,0,255);
    pushMatrix();
    translate(x,y);
    drawDay(days.getJSONObject(i), i);
    popMatrix();
  }
}

void drawDay(JSONObject day, int numDay){
  float illum = day.getFloat("illumination");
  stroke(0);
  rect(0,0,dayWidth,dayWidth);
  if (Float.isNaN(illum)){
    return;
  }
  
  fill((illum/100.0)*255);
  ellipse(dayWidth/2,dayWidth/2,moonSize,moonSize);
  fill(255,0,255);
  float ratio = (illum)/100.0;

  stroke(255,255,0);
  int xpos = getXShadowPos(ratio, numDay);
  line(xpos,0,xpos,dayWidth);
  
  int ypos1 = getYShadowPos(xpos-(dayWidth/2));
  int ypos2 = ypos1 - 2*(ypos1 - dayWidth/2);
  println(xpos-(dayWidth/2));
  line(0,ypos1,dayWidth,ypos1);
  line(0,ypos2,dayWidth,ypos2);
}

int getXShadowPos(float ratio, int numDay){
  if (numDay <= 4){
    //ratio *= -1;
    //ratio = 1.0 - ratio;
    ratio = 1 - ratio;
  }
  else if (numDay >19){
    ratio = 1 - ratio;
  }  
  return (int)(dayWidth-(moonSize*1.5) + (ratio*moonSize));
}

int getYShadowPos(int xDist){
  return dayWidth/2 + (int)(sqrt((moonSize/2)*(moonSize/2) - xDist*xDist)); 
}
