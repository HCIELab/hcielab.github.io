//drag and slide to draw a line, the incline at which you draw it on shall represent the slope that the slider will be on 
//the components will be rectangles



class Slider{
  
  int mode = 0;//rectangle default mode 1 is the polygon mode
  float intensity =0;//the first square starts at 0
  double intensity_percent = 0;
  float height_unit = 20;
  float width_unit = 20;//the height and width of each one of the intensity nobs of the bard
  float num_rects =0;
  float startx = 0;
  float starty = 0;
  float endx = 0;
  float endy = 0;
  float stagger_unit = 0;
  float m = 0;
  boolean stack = true;
  boolean interract = false;
  //the bottom edge or top edge of the rectangles should be located at the bottom of the cursor
  
  float drag_startx =0;
  float drag_starty = 0;
  float drag_endx = 0;
  float drag_endy = 0;
  
  float xclicked =0 ;
  float yclicked =0 ;
  float delta_x = 0;
  float delta_y =0;
  
  boolean in_slider= false;
  
  Slider(){
    
    startx = mouseX;
    starty = mouseY;
    endx = mouseX;
    endy = mouseY;
    
  }//Slider()
  
  Slider(float x1, float y1, float x2, float y2){

    startx= x1;
    starty = y1;
    endx = x2;
    endy = y2;
    slope();
  }
  
  public void setIntensity(){
    drag_endx = mouseX;
    drag_endy = mouseY;
  }
  
  
  
  public void drawSlider(){
    rectMode(CENTER);
    if(interract){
      inSquare();
    }
  
    for (int i =0;i<num_rects;i++){
      if(intensity>=i) fill(255,85,0);//if the cursor is over this part of the rectangle turn it orangeish red
      if(stack){
        if((endy -starty)>0){
          rect(startx+(i*stagger_unit)+delta_x,starty+(i*(height_unit+3))+delta_y,width_unit,height_unit);
        }
        else{
          rect(startx+(i*stagger_unit)+delta_x,starty+(-i*(height_unit+3))+delta_y,width_unit,height_unit);
        }
      }
      else{
        if(endx-startx>0){
          rect(startx+(i*(width_unit+3))+delta_x,starty+(i*stagger_unit)+delta_y,width_unit,height_unit);
        }
        else{
          rect(startx+(-i*(width_unit+3))+delta_x,starty+(i*stagger_unit)+delta_y,width_unit,height_unit);
        }
        
      }
      fill(255);
    }
  }//drawSlider()
  
  void inSquare(){
    
     for (int i =0;i<num_rects;i++){
      
        if(stack){
          if((endy -starty)>0){
            if((drag_endx <= startx+(i*stagger_unit)+width_unit/2) && (drag_endx >= startx+(i*stagger_unit)-width_unit/2) && (drag_endy <= (starty+(i*(height_unit+3))+height_unit/2) && (drag_endy >= -3+(starty+(i*(height_unit+3))-height_unit/2)))){
              intensity = i;
            }
          }// corresponds to the 225 - 315 degrees of the sketch window
          else{
            if((drag_endx <= startx+(i*stagger_unit)+width_unit/2) && (drag_endx >= startx+(i*stagger_unit)-width_unit/2) && (drag_endy <= (starty+(-i*(height_unit+3)))+height_unit/2) && (drag_endy >= 3+(starty+(-i*(height_unit+3))-height_unit/2))){
              intensity = i;
            }
          }//45-135 degrees
        }
        else{
          if(endx-startx>0){
            if((drag_endx <= startx+(i*(width_unit+3))+width_unit/2) && (drag_endx >= -3+startx+(i*(width_unit+3))-width_unit/2) && (drag_endy <= starty+(i*stagger_unit)+height_unit/2) && (drag_endy >= starty+(i*stagger_unit)-height_unit/2)){
              intensity = i;
            }
          }//315-45
          else{
            if((drag_endx <= startx+(-i*(width_unit+3))+width_unit/2) && (drag_endx >= 3+startx+(-i*(width_unit+3))-width_unit/2) && (drag_endy <= starty+(i*stagger_unit)+height_unit/2) && (drag_endy >= starty+(i*stagger_unit)-height_unit/2)){
              intensity = i;
            }
          }//135-225
          
        }
      }//loop
      if(num_rects>1){        
        intensity_percent = 1.0*(intensity)/(num_rects-1);
      }
      else{
        intensity_percent = 0;
      }
    
  }//inSquare() is responsible for determining the intensity of the action the slider is responsible for 
  
    public void inSlider(){
         for (int i =0;i<num_rects;i++){
      
        if(stack){
          if((endy -starty)>0){
            if((mouseX <= startx+(i*stagger_unit)+width_unit/2) && (mouseX >= startx+(i*stagger_unit)-width_unit/2) && (mouseY <= (starty+(i*(height_unit+3))+height_unit/2) && (mouseY >= -3+(starty+(i*(height_unit+3))-height_unit/2)))){
              in_slider = true;
              break;
            }
          }// corresponds to the 225 - 315 degrees of the sketch window
          else{
            if((mouseX <= startx+(i*stagger_unit)+width_unit/2) && (mouseX >= startx+(i*stagger_unit)-width_unit/2) && (mouseY <= (starty+(-i*(height_unit+3)))+height_unit/2) && (mouseY >= 3+(starty+(-i*(height_unit+3))-height_unit/2))){
              in_slider = true;
              break;
            }
          }//45-135 degrees
        }
        else{
          if(endx-startx>0){
            if((mouseX <= startx+(i*(width_unit+3))+width_unit/2) && (mouseX >= -3+startx+(i*(width_unit+3))-width_unit/2) && (mouseY <= starty+(i*stagger_unit)+height_unit/2) && (mouseY >= starty+(i*stagger_unit)-height_unit/2)){
              in_slider = true;
              break;
            }
          }//315-45
          else{
            if((mouseX <= startx+(-i*(width_unit+3))+width_unit/2) && (mouseX >= 3+startx+(-i*(width_unit+3))-width_unit/2) && (mouseY <= starty+(i*stagger_unit)+height_unit/2) && (mouseY >= starty+(i*stagger_unit)-height_unit/2)){
              in_slider= true;
              break;
            }
          }//135-225
          
        }
        if(i==num_rects-1){
         in_slider = false; 
        }
      }//loop
      
      
  }//inSlider()
  
  public boolean getInSlider(){
   return in_slider; 
  }
  
  public void interract(boolean act){
    interract = act;
  }
  
 private void slope(){
    
   m = (endy -starty)/(endx-startx); //slope
   
   if(m>=1 || m<=-1){
     num_rects = (float)Math.ceil((double)(abs(((endy -starty)/(height_unit+3)))));//number of rectangles that should be drawn for the slider
     stagger_unit = (endx-startx)/num_rects;
     stack = true;
   }//vertical stack
   else{
     num_rects = (float)Math.ceil((double)(abs(((endx -startx)/(width_unit+3)))));
     stagger_unit = (endy-starty)/num_rects;
     stack = false;
   }//horizontal stack
   
  }//slope() updates the slope and other related variables needed to calculate where the cursor is
  
   public void movementStart(){
     xclicked = mouseX;
     yclicked = mouseY;
   }
   
   public void move(){
    if(in_slider){
      if(startx+mouseX - xclicked<width && endx+mouseX - xclicked<width && endx+mouseX - xclicked>0 && startx+mouseX - xclicked>0){
        if(starty+mouseY - yclicked<height && endy+mouseY - yclicked<height && endy+mouseY - yclicked>0 && starty+mouseY - yclicked>0){
          
          delta_x = mouseX - xclicked;//change in x
          delta_y = mouseY - yclicked;//change in y
        }
      }
    }
    
  }//move()
  
  void stopMoving(){
    in_slider = false;
    startx = startx+delta_x;
    starty = starty+delta_y;
    endx = endx+delta_x;
    endy = endy+delta_y;
    delta_x=0;
    delta_y=0;
  }//stopMoving
  
  public double getIntensity(){
   return intensity_percent; 
  }

  
  
}//outer Slider
