int Igniter = 2;
int Flow = 3;
int Vent = 4;

void setup() {
  // put your setup code here, to run once:
  pinMode(Igniter, OUTPUT);
  pinMode(Flow, OUTPUT);
  pinMode(Vent, OUTPUT);

  Serial.begin(9600);
  digitalWrite(Igniter, LOW);
  digitalWrite(Flow, HIGH);
  digitalWrite(Vent, HIGH);
}

void loop() {
  // put your main code here, to run repeatedly:
  digitalWrite(Igniter, HIGH);
  delay(1000);
  digitalWrite(Igniter, LOW);
  digitalWrite(Flow, LOW);
  delay(1000);
  digitalWrite(Flow, HIGH);
  digitalWrite(Vent, LOW);
  delay(1000);
  digitalWrite(Vent, HIGH);

}
