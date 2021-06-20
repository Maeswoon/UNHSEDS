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
volatile unsigned long startTime;
volatile int step = 0;

volatile bool panicOnce = true;



void setup() {

  //pin for waiting to start the functionality of the motor until the server is ready
  //this will be low when we dont wanna do anything, high when we do
  // we will be recieving this from pin 5 on the server
  pinMode(10 , INPUT);

  Serial.begin(9600); 
  
  // prime the interrupt pins
   pinMode(interruptPin, INPUT_PULLUP);
  //trigger the interrupt whenever a change is detected
  attachInterrupt(digitalPinToInterrupt(interruptPin), closeInterrupt, LOW);
  
}

void loop() {

  // check for a server message saying "start working"
  //if step is 999 or higher an interrupt has been triggered
  while( digitalRead(10) == LOW && !(step >= 999) ) {
    //do nothing but wai
    //Serial.println("waiting on go");
  }


  //first thing I want to do is to check if the time is up to stop moving, if it is stop.
  unsigned long currentMills = millis();
  noInterrupts();
  if( currentMills - previousMills > savedTimeToMove ) {
    interrupts();
    //stop mving the motor
    analogWrite(pwmPin, 0);
    waiting = false;
    step = step + 1;
    //charlie wants a .5 sec wait between adjustments

    if (step != 100 ) {
    delay(500);
    } else {
      analogWrite(pwmPin, 0);
      Serial.println("hard bail, system closed");
      delay(99999);
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


  if(step == 1) {
    //ram open to that position i have saved in milliseconds
  startTime = millis();
  digitalWrite(in1, HIGH);
  digitalWrite(in2, LOW);
  
  //place spot in milliseconds here, as well as speed to go there ( if we're finding it at 70 then should prob go to 70)
  move(10000, 115);

  
  Serial.println("speeding to point");
  waiting = true;
  }
  
  if (step == 2 || step == 3 || step == 4) {
   //few pulses
  // creep foreward real slow

  digitalWrite(in1, HIGH);
  digitalWrite(in2, LOW);
  move(200, 115);
  Serial.println("pulse");
  waiting = true;
  }
  if (step == 5 ) {
    //ram open, dump tank by waiting 30sec

  digitalWrite(in1, HIGH);
  digitalWrite(in2, LOW);
  move(5000, 115);
  Serial.println("full open");
  waiting = true;
    
  }
  if (step == 6) {
    //wait 30 sec to dump fuel
    move(30000, 0);
    waiting = true;
  }
  
  if (step == 7) {
    //a check to see if were pulsed thru
  digitalWrite(in1, LOW);
  digitalWrite(in2, HIGH);
  move(17000, 115);
  Serial.println("2, close");
  waiting = true;
  } else{

  }

   }
  interrupts();
}




void closeInterrupt() {

  if (panicOnce) {
  
  digitalWrite(in1, LOW);
  digitalWrite(in2, HIGH);
  analogWrite(pwmPin, 115);
  // save how long to keep moving
  savedTimeToMove = 30000;
  // save when you started
  previousMills = millis();
  Serial.println("lets bail");
  waiting = true;
  step = 999;

  
  unsigned long currentTime = millis();
  unsigned long moveTime = currentTime - startTime;
  Serial.print("stop interrupt at: ");
  Serial.println(moveTime);
  panicOnce = false;
  }

}
