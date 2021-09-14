class Button{
  
  //used for drawing the buttons
  float mousex_start = 0;
  float mousey_start = 0;
  float mousex_end = 0;
  float mousey_end = 0;
  String shape = "Rectangle";//setting this as default but its not really default
  
  //used for moving the buttons
  float delta_x = 0;
  float delta_y =0;
  boolean is_moving = false;
  boolean button_selected = false;
  
  //used for changing color of the buttons
  boolean yellow = false;
  
  //triangle specific variables
  float x3 = 0;
  float y3 = 0;
  String drag_type = "up";

  
  Button(float startx, float starty, String control_mode){
    mousex_start = startx;
    mousey_start = starty;
    mousex_end = startx;
    mousey_end = starty;
    x3 = startx;
    y3 = starty;
    
    shape = control_mode;
    
    rectMode(CORNERS);
    ellipseMode(CORNERS);
  }
  
  Button(float x1, float y1, float x2, float y2, String mode){
    //476.0 150.0476 150300.0 463.0371 540152.0 445.0252 55229.0 464.0108 535
    
    mousex_start = x1;
    mousey_start = y1;
    mousex_end = x2;
    mousey_end = y2;
    
    this.shape = mode;//set the shape mode which is important for drawing the object
    
  }
  
  public void drawButton(){
    
    if (yellow){
     fill(255,255,0); 
    }
    
    rectMode(CORNERS);
    ellipseMode(CORNERS);
    
    if(shape.equals("Rectangle")){
      if(is_moving){
        rect(mousex_start+delta_x, mousey_start+delta_y, mousex_end+delta_x, mousey_end+delta_y,7);
      }//if the button is already moving
      else{
        rect(mousex_start, mousey_start, mousex_end, mousey_end,7);
      }
      
    }
    if(shape.equals("Ellipse")){
      if(is_moving){
        ellipse(mousex_start+delta_x, mousey_start+delta_y, mousex_end+delta_x, mousey_end+delta_y);
      }//if the button is already moving
      else{
        ellipse(mousex_start, mousey_start, mousex_end, mousey_end);
      }      
    }
   
    fill(255);
    strokeWeight(1);
    
  }//drawButton draws the button
  
  public float[] getCords(){
    //returns coordinates of the button in order of size
    float x_big =0;
    float x_small = 0;
    float y_big =0;
    float y_small = 0;
    
    if(mousex_start<mousex_end){
     x_big =  mousex_end;
     x_small = mousex_start;
    }
    else{
     x_big =  mousex_start;
     x_small = mousex_end;
    }
    
    if(mousey_start<mousey_end){
     y_big =  mousey_end;
     y_small = mousey_start;
    }
    else{
     y_big =  mousey_start;
     y_small = mousey_end;
    }
    
   return new float[]{x_small, x_big, y_small, y_big};
   
  }
  
  void change_color(){
    yellow = !yellow;//change the color of the button
  }//changeColorchanges color of button
  
  void moveButton(float xclicked, float yclicked){
    //xclicked and yclicked are the points where the user clicked the mouse to move the button
    //update the rectangle location globally
    //move the button by the same amount you move the mouse
       
    delta_x = mouseX - xclicked;//change in x
    delta_y = mouseY - yclicked;//change in y
    
    float overboard =0;
    
    if(0>mousex_start+delta_x){
      overboard = mousex_start+delta_x;
      delta_x = delta_x-overboard;
    }
    if(mousex_end+delta_x>width){
      overboard = mousex_end+delta_x-width;
      delta_x = delta_x-overboard;
    }
    if(0>mousey_start+delta_y){
      overboard = mousey_start+delta_y;
      delta_y=delta_y-overboard; 
    }
    if( mousey_end+delta_y>height){//if past the borders
      overboard = mousey_end+delta_y-height;
      delta_y = delta_y-overboard;
      
    }
    
    is_moving = true;
    
  }//moveButton() moves da button
  
  public boolean inButton(){
    
    float [] cords = getCords();
    
    if (shape.equals("Rectangle")){
      if (mouseX>= cords[0] && mouseX<=cords[1] && mouseY>=cords[2] && mouseY <= cords[3]){
        return true;
      }
    } 
    else if(shape.equals("Ellipse")){
      if (mouseX>= cords[0] && mouseX<=cords[1] && mouseY>=cords[2] && mouseY <= cords[3]){
        return true;
      }
    }
    
    return false;
  }//inButton() returns boolean of weather the user has clicked within the button
  
  public boolean getIsMoving(){
    return is_moving;
  }//getIsMoving returns boolean isMoving
  
  public void stopMoving(){
    
    mousex_start = mousex_start+delta_x;
    mousey_start=mousey_start+delta_y;
    mousex_end=mousex_end+delta_x;
    mousey_end=mousey_end+delta_y;
    
    //if its a triangle you have to take the other vertices into account
      
    x3 = x3+delta_x;
    y3 = y3+delta_y;
    
    delta_x=0;
    delta_y =0;
    
    is_moving =  false;
    
  }//setIsMoving() lets the user set wether the button is moving or not
  
  public void setButtonSelected(boolean select){
    button_selected =select;
  }
  
  public boolean getButtonSelected(){
    return button_selected;
  }
  

  

  

  
}
