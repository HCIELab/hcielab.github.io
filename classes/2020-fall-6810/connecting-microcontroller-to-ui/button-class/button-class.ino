const int INPUT_PIN = 19;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);               // Set up serial port
  pinMode(INPUT_PIN, INPUT_PULLUP);
}

void loop() {
  // put your main code here, to run repeatedly:

    int value = digitalRead(INPUT_PIN);
    if (value){
        //executed if pin is HIGH (voltage of 3.3V)
//       Serial.println("unpushed");
       Serial.write(0);
    }else{ 
        //executed if pin is LOW (voltage of 0V)
//       Serial.println("pushed"); 
       Serial.write(1); 
    }
    delay(100);
}
