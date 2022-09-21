
//----- Circuit Pin Recommendations -----
// PWM pin: 16
// Multiplexer Select Pins: 17, 5, 18, 19
// SPI pins for MCP3008 ADC chip (sck, mosi, miso, cs): (14, 13, 12, 25)

//----- TODO: Include library for MCP3008 -----


//----- TODO: Multiplexer input pins (for ESP32) -----


//----- TODO: Number of receiver (RX) and transmitter (TX) lines -----
int numRx = 0;
int numTx = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);

  //----- TODO: Identify the GPIO pin and assign PinMode -----
  

  //----- TODO: Setup PWM Channel -----
  setupPWM();
  
  //----- TODO: Initialize MCP3008 chip with SPI -----
  
}

void loop() {
  // put your main code here, to run repeatedly:
  //----- TODO: Read through the receiver pins periodically -----
  
}


//----- TODO: Setup PWM Channel -----
void setupPWM(){
  
}

//----- TODO: Set Select Pin Values -----
void selectChannelOut(int channel) {
    
    // leave this delay at the end of the function,
    // this is for mux to stabilize after each select pin values assignment
    // you can adjust the delay value 
    delay(2);  
}
