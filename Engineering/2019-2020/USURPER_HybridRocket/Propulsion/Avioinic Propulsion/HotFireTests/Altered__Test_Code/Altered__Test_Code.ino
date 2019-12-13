int pwmPin = 5;    // motor connected to digital pin 5
int in1 = 3;
int in2 = 6;

const byte interruptPin = 2;
int count = 1;

void setup() {
  // put your setup code here, to run once:
  pinMode(9, OUTPUT);
  pinMode(10 , INPUT);
  pinMode(11 , INPUT);
  pinMode(3 , OUTPUT);
  pinMode(6 , OUTPUT);
  pinMode(5 , OUTPUT); 
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
  // put your main code here, to run repeatedly:
 if (digitalRead(10) == LOW && digitalRead(11) == LOW) {
    Serial.print("Waiting for go signal\n");
  }
  
  else if (digitalRead(10) == HIGH && digitalRead(11) == LOW && count == 1) {
    Serial.print("Igniting\n");
    digitalWrite(9, HIGH);                //Igniter 
    delay(3500);                          //Delay for burn
    digitalWrite(9, LOW);

    // HALF OPEN
    digitalWrite(in2, HIGH);              //Direction --> Reverse
    analogWrite(pwmPin, 255);             //digitalWrite(pwmPin, HIGH);           //Speed
    Serial.print("Opening\n");
    delay(900);                          //For how long
    digitalWrite(in1, LOW);
    digitalWrite(in2, LOW);
    delay(5000);
    
    // FULLY OPEN
    Serial.println("Done Opening");                                       //Serial.print("Full Open\n");
    digitalWrite(in2, HIGH);
    analogWrite(pwmPin, 255);
    delay(500);
    digitalWrite(in1, LOW);
    digitalWrite(in2, LOW);
    delay(5000);                            //Run this line for testing
    //delay(180000);                        //Run this line for hot fires

    //FULLY CLOSING
    digitalWrite(in1, HIGH);
    analogWrite(pwmPin, 255);
    delay(1400);
    digitalWrite(in1, LOW);
    digitalWrite(in2, LOW);
    
    
    //digitalWrite(in1, LOW);
    //digitalWrite(in2, HIGH);
    Serial.print("Closed\n");
    //delay(1500);
    //digitalWrite(in1, LOW);
    //digitalWrite(in2, LOW);
    count++;
  }
  }
