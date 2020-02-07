int vent = 5;   // Vent solenoid digital pin 5
int flow = 6;   // Flow solenoid digital pin 4
int lswitch = 10; // Launch Switch to digital 10
int button = 13; // Abort launch button to digital 12
int igniter = 9; // Igniter on digital 9
int bridge = 11;

int counter = 0; // Counter to run ignition sequence once
//const byte interruptPin = 2;

void setup() {
  // put your setup code here, to run once:
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  pinMode(10, INPUT);
  pinMode(13, INPUT);
  pinMode(11, INPUT);
   
  Serial.begin(9600); 
  
  // prime the interrupt pins
  //pinMode(interruptPin, INPUT_PULLUP);
  digitalWrite(5, LOW);
  digitalWrite(6, LOW);
  digitalWrite(9, LOW);
  digitalWrite(10, LOW);
  digitalWrite(13, LOW);
  digitalWrite(11, LOW);
  
}

void loop() {
  
  if (digitalRead(10) == LOW && digitalRead(13) == LOW) {
    Serial.print("Waiting for ignition signal\n");
  }
  
  while (digitalRead(10) == HIGH && digitalRead(13) == LOW && counter == 0 ) {
    digitalWrite(5, HIGH);           //Vent Solenoid Open
    Serial.print("Aborting Launch\n");
    //delay(180000);
    digitalWrite(5, LOW);

  }
  
  if (digitalRead(13) == HIGH && counter == 0) {
    Serial.print("Igniting\n");
    digitalWrite(igniter, HIGH);           //Ignite E-match 
    //delay(3500);                          //Delay for burn
    delay(1000);
    digitalWrite(igniter, LOW);

    // OPEN SOLENOID
    digitalWrite(6, HIGH);           //Flow Solenoid Open
    Serial.print("Flow Open\n");
    //delay(180000);
    delay(5000);
    
    // CLOSE SOLENOID
    digitalWrite(6, LOW);            //Flow Solenoid Closed
    Serial.print("Flow Closed\n");

    counter++;
  }
  }
