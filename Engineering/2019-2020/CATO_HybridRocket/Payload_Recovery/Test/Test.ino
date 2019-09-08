int pwmPin = 5;    // motor connected to digital pin 5
int in1 = 3;
int in2 = 6;
int counter = 0;

const byte interruptPin = 2;


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
  
  if (digitalRead(10) == LOW && digitalRead(11) == LOW) {
    Serial.print("Waiting for go signal\n");
  }
  
  else if (digitalRead(10) == HIGH && digitalRead(11) == LOW && counter == 0) {
    digitalWrite(9, HIGH);
    delay(50);
    digitalWrite(9, LOW);
    delay(3500);
    Serial.print("Igniting\n");
    digitalWrite(in1, HIGH);
    digitalWrite(pwmPin, HIGH);
    Serial.print("Opening\n");
    delay(1550);
    digitalWrite(in1, LOW);
    digitalWrite(in2, LOW);
    Serial.print("Full Open\n");
    delay(10000);
    digitalWrite(in1, LOW);
    digitalWrite(in2, HIGH);
    Serial.print("Closed\n");
    delay(1500);
    digitalWrite(in1, LOW);
    digitalWrite(in2, LOW);
    counter++;
  }

  if ( counter > 0 ) {
    digitalWrite(in1, LOW);
    digitalWrite(in2, LOW);
  }
  
  if (digitalRead(11) == HIGH) {
    digitalWrite(in1, LOW);
    digitalWrite(in2, HIGH);
    delay(1500);
    digitalWrite(in1, LOW);
    digitalWrite(in2, LOW);
  }
  }
