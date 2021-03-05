
int bar_height = 200;

// variables that control the height of the bars
boolean touch_0 = false;
boolean touch_1 = true;
boolean touch_2 = false;

  /***********************************************/
  // Serial communication is declaredd here
  /***********************************************/

void setup() {
  
  rectMode(CORNERS);
  
  size(700,500);
  
  /***********************************************/
  // Serial communication is instantiated here
  /***********************************************/
 
}

void draw() {

  background(255,220,255);
  
  
  /***********************************************/
  // Serial messages are received here
  /***********************************************/
  
  //changes height of a bar depending on touch_0
  fill(255,100,100);
  rect(100,400-(touch_0?1:0.1)*bar_height,200,400);
  
  //changes height of a bar depending on touch_1
  fill(100,255,100);
  rect(300,400-(touch_1?1:0.1)*bar_height,400,400);
  
  //changes height of a bar depending on touch_2
  fill(100,100,255);
  rect(500,400-(touch_2?1:0.1)*bar_height,600,400);
  
  
}
