#include <Servo.h>

Servo topServo;  // create servo object to control a servo
Servo botServo;
// twelve servo objects can be created on most boards

int pos = 0;    // variable to store the servo position
int pos2 = 0;

void setup() {
  Serial.begin(9600);
  topServo.attach(10);  // attaches the servo on pin 9 to the servo object
  botServo.attach(9);
}

void loop() {

  for (int do3 = 0; do3 < 3; do3++) {
  topServo.write(73);
  botServo.write(90);
  delay(30);

//bring top to max 
for( int y=73; y<= 107; y++ ) {
  Serial.println(y);
  topServo.write(y);
  delay(30);
}
//bringback to 0
for( int y=107; y>= 73; y-- ) {
  Serial.println(y);
  topServo.write(y);
  delay(30);
}
//bring back to 90
for( int y=73; y<= 90; y++ ) {
  Serial.println(y);
  topServo.write(y);
  delay(30);
}


//do bot servo

//bring bot to max 
for( int y=73; y<= 107; y++ ) {
  Serial.println(y);
  botServo.write(y);
  delay(30);
}
//bringback to 0
for( int y=107; y>= 73; y-- ) {
  Serial.println(y);
  botServo.write(y);
  delay(30);
}
//bring back to 90
for( int y=73; y<= 90; y++ ) {
  Serial.println(y);
  botServo.write(y);
  delay(30);
}

//delay(10000);
 }

/*
for(int i=0; i<=360; i++){
      float j = 17 * (cos ((3.14 * i)/180)) + 90;
      float k = 17 * (sin ((3.14 * i)/180)) + 90;
      topServo.write(j);
      botServo.write(k);
      Serial.print(j);
      Serial.print(",");
      Serial.println(k);
      delay(15);
}

delay(10000);

*/




  

}
