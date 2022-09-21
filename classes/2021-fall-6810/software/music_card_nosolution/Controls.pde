//The controls class has 4 modes
/*
     "Interact": lets you interact with the buttons using the serial buttons

     "Hide": hides the button
   
     "Show": shows the buttons
     
     "Edit": lets you move, delete, and change the color of the buttons
*/

class Controls{
 
  String mode;
 
  Controls(){
      
    mode = "Show";
  
  }
    
  
  public String getMode(){    
     return this.mode;     
  }//getMode
  
  public void setMode(String s){
    this.mode = s;
  }
  
  
  
}//Controls class
  
  
  
  
  
  
