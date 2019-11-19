int pwmPin = 5;    // motor connected to digital pin 5
int in1 = 4;
int in2 = 6;

const byte interruptPin = 2;
int count = 1;


void setup() {
  // put your setup code here, to run once:
  pinMode(9, OUTPUT);
  pinMode(10, INPUT);
  pinMode(11, INPUT);
  pinMode(in1, OUTPUT);
  pinMode(in2, OUTPUT);
  pinMode(5, OUTPUT); 
  Serial.begin(9600); 
  
  // prime the interrupt pins
  pinMode(interruptPin, INPUT_PULLUP);
  digitalWrite(in1, LOW);
  digitalWrite(in2, LOW);
  digitalWrite(9, LOW);
  digitalWrite(10, LOW);
  digitalWrite(11, LOW);
  
}

void loop() {
  
  if (digitalRead(10) == LOW && digitalRead(11) == LOW) {
    digitalWrite(9, LOW);
    digitalWrite(in1, LOW);
    digitalWrite(in2, LOW);
    analogWrite(pwmPin, 0);
    Serial.print("Waiting for go signal\n");
  }
  
  else if (digitalRead(10) == HIGH && digitalRead(11) == LOW && count == 1) {
    Serial.print("Igniting\n");
    digitalWrite(9, HIGH);                //Igniter 
    delay(3500);                          //Delay for burn
    digitalWrite(9, LOW);

    // HALF OPEN
    digitalWrite(in1, HIGH);              //Direction --> Reverse
    analogWrite(pwmPin, 255);             //digitalWrite(pwmPin, HIGH);           //Speed
    Serial.print("Opening\n");
    delay(1100);                          //For how long
    digitalWrite(in1, LOW);
    digitalWrite(in2, LOW);
    delay(3000);
    
    // FULLY OPEN
    Serial.println("Done Opening");                                       //Serial.print("Full Open\n");
    digitalWrite(in1, HIGH);
    analogWrite(pwmPin, 150);
    delay(2700);
    digitalWrite(in1, LOW);
    digitalWrite(in2, LOW);
    delay(180000);

    //FULLY CLOSING
    digitalWrite(in2, HIGH);
    analogWrite(pwmPin, 255);
    delay(1750);
    digitalWrite(in1, LOW);
    digitalWrite(in2, LOW);
    
    Serial.print("Closed\n");
    count++;
    Serial.print(count);
    
  }

  while (digitalRead(11) == HIGH) {
    digitalWrite(in1, LOW);
    digitalWrite(in2, HIGH);
    delay(1500);
    digitalWrite(in1, LOW);
    digitalWrite(in2, LOW);
    break;
  }
  }
