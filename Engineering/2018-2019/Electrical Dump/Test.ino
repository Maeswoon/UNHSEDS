int pwmPin = 5;    // motor connected to digital pin 5
int in1 = 3;
int in2 = 6;

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
  
  else if (digitalRead(10) == HIGH && digitalRead(11) == LOW) {
    digitalWrite(in1, HIGH);
    digitalWrite(pwmPin, HIGH);
    Serial.print("Opening\n");
    delay(1550);
    digitalWrite(in1, LOW);
    digitalWrite(in2, LOW);
    Serial.print("Full Open\n");
    delay(2500);
    digitalWrite(9, HIGH);
    delay(50);
    digitalWrite(9, LOW);
    Serial.print("Igniting\n");
    delay(180000);
    digitalWrite(in1, LOW);
    digitalWrite(in2, HIGH);
    Serial.print("Closed\n");
    delay(1500);
    digitalWrite(in1, LOW);
    digitalWrite(in2, LOW);
    //counter++;
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
