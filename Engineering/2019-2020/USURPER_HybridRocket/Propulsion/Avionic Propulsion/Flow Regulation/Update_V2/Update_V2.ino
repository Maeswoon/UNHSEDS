int flow = 3; // Flow Solenoid to digital 5
int lswitch = 10; // Launch Switch to digital 10

int counter = 0; // Counter to run ignition sequence once

void setup() {
  // put your setup code here, to run once:
pinMode(5, OUTPUT);
pinMode(10, INPUT);
Serial.begin(9600);

digitalWrite(flow, LOW);
digitalWrite(lswitch, LOW);
}

void loop() {
  // put your main code here, to run repeatedly:

if (digitalRead(lswitch) == LOW) {
  Serial.print("Waiting for ignition signal\n");
}
else if (digitalRead(lswitch) == HIGH && counter == 0) {
  Serial.print("Flow Open\n");
  digitalWrite(flow, HIGH);
  //delay(3000);
  //Serial.print("Flow Closed\n");
  //digitalWrite(flow, LOW);
  
  counter++;
}
}
