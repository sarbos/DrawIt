#include <SoftwareSerial.h>
#include <Adafruit_NeoPixel.h>

#define LEDPin 10
#define Btx 9
#define Brx 8
#define Bkey 7
#define Bstat 6
#define DrawB 4
#define ModeB 3
#define IRpin 2

//the mode we are set on
//0 = Music
//1 = LG
//2 = Draw
int mode = 0;

Adafruit_NeoPixel strip = Adafruit_NeoPixel(6, LEDPin, NEO_GRB + NEO_KHZ800);
SoftwareSerial BT(9,8);

void setup()
{
  strip.begin();
  strip.show();
  
  //set up pins
  pinMode(Bkey, OUTPUT);
  pinMode(Bstat, INPUT);
  pinMode(DrawB, INPUT);
  pinMode(ModeB, INPUT);
  pinMode(IRpin, OUTPUT);
  
  //activate internal pullups
  digitalWrite(DrawB, HIGH);
  digitalWrite(ModeB, HIGH);
  
  //start comms to on board bt module
  BT.begin(9600);
  delay(500);
  while(!digitalRead(Bstat))
 {
     for (int i=0; i<6; i++)
      {
         strip.setPixelColor(i,200,0,0);
      }
      strip.show();
      delay(250);
      for (int i=0; i<6; i++)
      {
          strip.setPixelColor(i,0,0,0);

      }
      strip.show();
      delay(250);
 }
 for (int i=0; i<6; i++)
  {
     strip.setPixelColor(i,0,200,0);
  }
  strip.show();
  delay(1000);
  
}
void loop()
{
 for (int i=0; i<6; i++)
  {
     strip.setPixelColor(i,0,0,200);
  }
  strip.show();
}
