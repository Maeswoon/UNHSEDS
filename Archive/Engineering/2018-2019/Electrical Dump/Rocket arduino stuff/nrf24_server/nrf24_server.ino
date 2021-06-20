// nrf24_server.pde
// -*- mode: C++ -*-
// Example sketch showing how to create a simple messageing server
// with the RH_NRF24 class. RH_NRF24 class does not provide for addressing or
// reliability, so you should only use RH_NRF24  if you do not need the higher
// level messaging abilities.
// It is designed to work with the other example nrf24_client
// Tested on Uno with Sparkfun NRF25L01 module
// Tested on Anarduino Mini (http://www.anarduino.com/mini/) with RFM73 module
// Tested on Arduino Mega with Sparkfun WRL-00691 NRF25L01 module

#include <SPI.h>
#include <RH_NRF24.h>

// Singleton instance of the radio driver
RH_NRF24 nrf24;

// check for dif in messages

bool firstTime = true;

bool oneTimeReset = true;

void setup() 
{
  
  Serial.println("Setting up");
  
  //This pin is connected to Pedro's launch circut in order to trigger the inital lighting of the rocket
  pinMode(4, OUTPUT);
  digitalWrite(4, LOW);

  //used to send an interrupt signal, when it is low the motor hard closes
  pinMode(2, OUTPUT);
  digitalWrite(2, HIGH);

  // this pin will be used to power the motor controller arduino's reset pin
  pinMode(5, OUTPUT);
  digitalWrite(5, LOW);


  
  
  Serial.begin(9600);
  while (!Serial) 
    ; // wait for serial port to connect. Needed for Leonardo only
  if (!nrf24.init())
    Serial.println("init failed");
  // Defaults after init are 2.402 GHz (channel 2), 2Mbps, 0dBm
  if (!nrf24.setChannel(1))
    Serial.println("setChannel failed");
  if (!nrf24.setRF(RH_NRF24::DataRate2Mbps, RH_NRF24::TransmitPower0dBm))
    Serial.println("setRF failed");    
}


void loop()
{


  
  if (nrf24.available())
  {
    // Should be a message for us now   
    uint8_t buf[RH_NRF24_MAX_MESSAGE_LEN];
    uint8_t len = sizeof(buf);
    if (nrf24.recv(buf, &len))
    {

      //panic button 19
      // hello is 13


      // 223 is a hello world
      if( len == 13 ) {

        if(oneTimeReset == true) {
        
        Serial.println("LAUNCH REQUEST");

              // Send a reply
        uint8_t data[] = "And hello back to you";
        nrf24.send(data, sizeof(data));
        nrf24.waitPacketSent();
        Serial.println("Sent a reply, launching rocket now");

  
        digitalWrite(4, HIGH);
        delay(300);
        digitalWrite(4, LOW);  
        // unnessasary? digitalWrite(2, HIGH);

        

        //bang the reset button to start the motor
        
        //delay(3000); // all pin five stuff may be excess stuff, pin 2 may be key reset pin? maybe 2 is useless?
        Serial.println("RESET");
        digitalWrite(5, HIGH);
        //delay(100);
        //digitalWrite(5, LOW);
        oneTimeReset = false;
        } else {
          Serial.println("Duplicate Launch Request");
        }
        
      }


            if( len == 19 ) {
        Serial.println("PANIC STOP");

        

              // Send a reply
        uint8_t data[] = "PANIC STOP";
        nrf24.send(data, sizeof(data));
        nrf24.waitPacketSent();
        Serial.println("sending stop signal");

        //hard code the panic stop
        digitalWrite(2, LOW); 
        delay(500);
        digitalWrite(2, HIGH);
 
      }
      


      
    }
    else
    {
      Serial.println("recv failed");
    }
  }
}
