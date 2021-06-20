//20 teeth on little gear
//17 teeth to rotate 90 on big gear

//85% of full rotation will give 90 degrees

int pwmPin = 5;    // motor connected to digital pin 5
int in1 = 3;
int in2 = 6;
const byte interruptPin = 2;
volatile unsigned long previousMills;
volatile long savedTimeToMove;
volatile bool waiting = false;
int step = 1;

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

    if (step != 100 ) {
    delay(4000);
    } else {
      analogWrite(pwmPin, 0);
      Serial.println("hard bail, system closed");
      delay(100000);
    }
  }
  interrupts();

  
 demo();
  
}

void move(int delayTime, int speed) {

  analogWrite(pwmPin, speed);
  // save how long to keep moving
  savedTimeToMove = delayTime;
  // save when you started
  previousMills = millis();

  // dont delay and stop here anymore, check time in loop and stop it there
  //delay(delayTime);
  // analogWrite(pwmPin, 0);

}




// this will open full, then 3/4, then 1/2, then 1/4 with 4 sec in between

void demo() {

noInterrupts();
   if ( waiting == false ) {
interrupts();

  
  if (step == 1) {
  // open full, start opeining clockwise
  Serial.println("Start Demo");

  digitalWrite(in1, HIGH);
  digitalWrite(in2, LOW);
  move(1530, 127);
  Serial.println("1, open");
  //delay(4000);
  waiting = true;
  }

  if ( step == 2) {
  // start closing, first 3/4, so move 1/4 in opposite direction (1/4 of the 1530 full move) ~= 382.5, (can use delayMicroseconds() if rounding hurts stuff)
  digitalWrite(in1, LOW);
  digitalWrite(in2, HIGH);
  move(383, 127);
  Serial.println("2");
  //delay(4000);
  waiting = true;
  }

  if (step == 3) {
  //now move to 1/2, we are at 3/4 fo we need to move another 1/4
  move(383, 127);
  Serial.println("3");
  //delay(4000);
  waiting = true;
  }

  if (step == 4) {
  // now move to 1/4, we are at 1/2 so move another 1/4
  move(383, 127);
  Serial.println("4");
  //delay(4000);
  waiting = true;
  }
   
  if(step == 5) {
  // now move to 0, we are at 1/4 so move another 1/4 to completley close
  move(383, 127);
  Serial.println("5, closed");
  //delay(4000);
  waiting = true;
  }

  if (step == 6) {
  //done hold up
  delay(99999);
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
  //delay(4000);
  waiting = true;
  step = 99;
}
