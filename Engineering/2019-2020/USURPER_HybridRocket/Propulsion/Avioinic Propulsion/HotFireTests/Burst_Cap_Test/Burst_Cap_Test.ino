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
  
  if (digitalRead(10) == LOW && digitalRead(11) == LOW) {
    Serial.print("Waiting for go signal\n");
  }
  
  else if (digitalRead(10) == HIGH && digitalRead(11) == LOW && count == 1) {
    Serial.print("Igniting\n");
    digitalWrite(9, HIGH);                //Igniter 
    delay(3500);                          //Delay for burn
    digitalWrite(9, LOW);

    count++;
  }


  }
