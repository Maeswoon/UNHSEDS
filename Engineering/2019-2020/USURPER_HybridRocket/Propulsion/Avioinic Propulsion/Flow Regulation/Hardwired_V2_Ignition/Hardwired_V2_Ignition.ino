int vent = 5;   // Vent solenoid digital pin 5
int flow = 4;   // Flow solenoid digital pin 4
int lswitch = 10; // Launch Switch to digital 10
int button = 11; // Abort launch to digital 11
int igniter = 9; // Igniter on digital 9

const byte interruptPin = 2;

void setup() {
  // put your setup code here, to run once:
  pinMode(vent, OUTPUT);
  pinMode(flow, OUTPUT);
  pinMode(lswitch, INPUT);
  pinMode(button, INPUT);
   
  Serial.begin(9600); 
  
  // prime the interrupt pins
  pinMode(interruptPin, INPUT_PULLUP);
  digitalWrite(vent, LOW);
  digitalWrite(flow, LOW);
  digitalWrite(lswitch, LOW);
  digitalWrite(button, LOW);
  digitalWrite(igniter, LOW);
}

void loop() {
  
  if (digitalRead(lswitch) == LOW && digitalRead(button) == LOW) {
    Serial.print("Waiting for go signal\n");
  }
  
  else if (digitalRead(lswitch) == HIGH && digitalRead(button) == LOW ) {
    Serial.print("Igniting\n");
    digitalWrite(igniter, HIGH);           //Ignite E-match 
    delay(3500);                          //Delay for burn
    digitalWrite(igniter, LOW);

    // OPEN SOLENOID
    digitalWrite(flow, HIGH);           //Flow Solenoid Open
    Serial.print("Flow Open\n");
    delay(180000);
    
    // CLOSE SOLENOID
    digitalWrite(flow, LOW);            //Flow Solenoid Closed
    Serial.print("Flow Closed\n");
  }
  
  else if (digitalRead(button) == HIGH ) {
    digitalWrite(vent, HIGH);           //Vent Solenoid Open
    Serial.print("Aborting Launch\n");
    delay(180000);
    digitalWrite(vent, LOW);
  }
  }
