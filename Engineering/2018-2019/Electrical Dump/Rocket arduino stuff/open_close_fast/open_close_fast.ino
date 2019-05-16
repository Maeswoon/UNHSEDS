
//20 teeth on little gear
//17 teeth to rotate 90 on big gear

//1043

//85% of full rotation will give 90 degrees

int pwmPin = 5;    // motor connected to digital pin 5
int in1 = 3;
int in2 = 6;
const byte interruptPin = 2;
volatile unsigned long previousMills;
volatile long savedTimeToMove;
volatile bool waiting = false;
volatile unsigned long startTime;
volatile int step = 1;

void setup() {

  Serial.begin(9600); 
  
  // prime the interrupt pin
   pinMode(interruptPin, INPUT_PULLUP);
  //trigger the interrupt whenever a change is detected
  attachInterrupt(digitalPinToInterrupt(interruptPin), closeInterrupt, FALLING);
  
}

void loop() {

  //first thing I want to do is to check if the time is up to stop moving, if it is stop.
  unsigned long currentMills = millis();
  noInterrupts();
  if( currentMills - previousMills > savedTimeToMove ) {
    interrupts();
    //stop mving the motor
    analogWrite(pwmPin, 0);
    waiting = false;
    step = step + 1;
    //charlie wants a 4 sec wait between adjustments

    if (step != 1000 ) {
    delay(2000);
    } else {
      analogWrite(pwmPin, 0);
      Serial.println("hard bail, system closed");
      delay(100000);
    }
  }
  interrupts();

  
 creepWithManualPause();
  
}

void move(int delayTime, int speed) {

  analogWrite(pwmPin, speed);
  // save how long to keep moving
  savedTimeToMove = delayTime;
  // save when you started
  previousMills = millis();

}





void creepWithManualPause() {
  
noInterrupts();
   if ( waiting == false ) {
interrupts();

  if(step == 999) {
    
  }
  if (step == 1) {
    //a check to see if were pulsed thru
  digitalWrite(in1, HIGH);
  digitalWrite(in2, LOW);
  move(1000, 255);
  Serial.println("2, close");
  waiting = true;
  }

  if (step == 2) {
    //a check to see if were pulsed thru
  digitalWrite(in1, LOW);
  digitalWrite(in2, HIGH);
  move(1000, 255);
  Serial.println("2, close");
  waiting = true;
  }

   }
  interrupts();
}




void closeInterrupt() {
  
  digitalWrite(in1, LOW);
  digitalWrite(in2, HIGH);
  analogWrite(pwmPin, 127);
  // save how long to keep moving
  savedTimeToMove = 1530;
  // save when you started
  previousMills = millis();
  Serial.println("lets bail");
  waiting = true;
  step = 999;

  
  unsigned long currentTime = millis();
  unsigned long moveTime = currentTime - startTime;
  Serial.print("stop interrupt at: ");
  Serial.print(moveTime);

}
