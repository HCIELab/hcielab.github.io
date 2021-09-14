import processing.serial.*;

/*
How to use this UI

left click to trigger a button or slider
right click and drag to UI elements
hover over button and press delete to delete the button
*/

Audio music;

PImage img;
ArrayList<Button> myButtons = new ArrayList<Button>();
ArrayList<Slider> mySliders = new ArrayList<Slider>();
String control_mode = "";
float x_clicked = 0;
float y_clicked = 0;
Controls control;

Serial myPort;
boolean released = true;
String val;

//settings() runs before setup and lets you put a variable in size
void settings(){
  //setting the size of the canvas to the size of the image
  size(861,480);
}

void setup() {
  img = loadImage("card.png");//loads image

  background(0);
  image(img, 0, 0);
  control = new Controls();
  
  /* ********************************************************************/
  // Todo: initialize Serial port
  /* ********************************************************************/
  


  /* ********************************************************************/
  // Todo: Add touch buttons
  /* ********************************************************************/
  
  //(a,b,c,d,type) These are coordinates for an ellipse
  //(a,b) is the upper right corner, (c,d) is the lower right corner of the ellipse
  myButtons.add(new Button(360.0, 180.0, 440, 260, "Ellipse"));//play/pause
  
  music = new Audio(this);
  
}

void draw() {
  
  background(0);
  image(img, 0, 0);
  control_mode = control.getMode();
  if(control_mode!= "Hide"){
    //You can show or hide the interactive elements here!
    for(int i=0;i<myButtons.size(); i++)
     myButtons.get(i).drawButton(); 
  }
  music.songFinished();
  
  /********************************************************************
  //TODO: Double check: Play/Pause Music, Go to Previous/Next Song Depending on Serial Message
  *********************************************************************/
  
  
  
}

void mousePressed(MouseEvent evt){

  if(mouseButton == LEFT){
    
     for (int i = 0; i< myButtons.size(); i++){
      if( myButtons.get(i).inButton()){//is the mouse on one of the buttons?
          
          /* ********************************************************************/
          // TODO: assign the function of the buttons here
          // Note that the order of declaring the buttons
          // affects the case numbers here (first object is 0 and so on)
          /* ********************************************************************/
          
          switch(i) {
           // case 0 adds the play/pause function to the button that was
           // declared first
           case 0 : if(!music.isPlaying())
                      music.play();
                    else 
                      music.pause();
                    break;
          }
        } 
        
      }
         
      for (int i = 0; i< mySliders.size(); i++){
        mySliders.get(i).inSlider();
      if( mySliders.get(i).getInSlider()){
          mySliders.get(i).interract(true);
        } 
      }
  }

  if (mouseButton == RIGHT){
    x_clicked = mouseX;
    y_clicked = mouseY;
    
    for (int i = 0; i< myButtons.size(); i++){
      if( myButtons.get(i).inButton()){
          myButtons.get(i).setButtonSelected(true);
        } 
      }
    for (int i = 0; i< mySliders.size(); i++){
      mySliders.get(i).inSlider();
      if( mySliders.get(i).getInSlider()){
          mySliders.get(i).movementStart();
        } 
      } 
  }
  
  
  
}

void mouseDragged(){
  
  if(mouseButton == RIGHT){
    if(0<mouseX && mouseX<width && 0<mouseY && mouseY<height){
      moveButton();//lets user move buttons
    }
  }
  
  if(mouseButton ==LEFT){
    
      for (int i = 0; i< mySliders.size(); i++){
        mySliders.get(i).inSlider();
      if( mySliders.get(i).getInSlider()){
          mySliders.get(i).interract(true);
          mySliders.get(i).setIntensity();
        } 
      }
  }
  
}//mouseDragged() responsible for resizing and moving buttons

void keyPressed(){
  
   if(key == DELETE){
     deleteButton();
   }
   if(key == 'h' || key=='H'){
     control.setMode("Hide");
   }
   if(key =='s' || key=='S'){
     control.setMode("Show");
   }
}

void mouseReleased(){
  //print("("+mouseX+", "+ mouseY+")");
  if(mouseButton == RIGHT){
     for (int i = 0; i< myButtons.size(); i++){
      if( myButtons.get(i).getIsMoving()){
        myButtons.get(i).stopMoving();
        myButtons.get(i).setButtonSelected(false);
      }//if a button is being moved and the mouse is released setIsMoving to false
     }
     for (int i = 0; i< mySliders.size(); i++){
       if(mySliders.get(i).getInSlider()){
         mySliders.get(i).stopMoving();
       }
     }
  }
}


void deleteButton(){
  
  for (int i =0 ; i< myButtons.size(); i++){
    if( myButtons.get(i).inButton()){
      myButtons.remove(i);
      i--;
    } 
  }
  
  for (int i = 0; i<mySliders.size();i++){
    mySliders.get(i).inSlider();
    if( mySliders.get(i).getInSlider()){
      mySliders.remove(i);
      i--;
    } 
  }
  
}//use the deleteButton to delete the button by hovering over the button and pressing delete

void moveButton(){
  //if you can move the button
  for (int i = 0; i< myButtons.size(); i++){
    if( myButtons.get(i).getButtonSelected()&&(myButtons.get(i).inButton() || myButtons.get(i).getIsMoving())){//basically if you have just clicked the button or if the button is already moving you can continue moving the button
        myButtons.get(i).moveButton(x_clicked, y_clicked);
        break;
      
    }
  }
    for (int i = 0; i< mySliders.size(); i++){
      
    if( mySliders.get(i).getInSlider()){//basically if you have just clicked the button or if the button is already moving you can continue moving the button
        mySliders.get(i).move();
        break;
      
    }
  } 
}//moveButton()

void buttonTouched(int button_touched){
      
  switch(button_touched){
     case 0: music.back();
             break;
     case 1: music.forward();
             break;
     case 2: if(!music.isPlaying())music.play();
             else music.pause();
             break;
   }
   
}//buttonTouched() if a real button is touched
