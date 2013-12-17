#include <SoftwareSerial.h>
#include <Adafruit_NeoPixel.h>

#define LEDPin 10
#define Btx 9
#define Brx 8
#define Bkey 7
#define Bstat 6
#define DrawB 4
#define ModeB 3

int mode = 0;
Adafruit_NeoPixel strip = Adafruit_NeoPixel(6, LEDPin, NEO_GRB + NEO_KHZ800);
SoftwareSerial mySerial(9,8);

void setup()
{
  strip.begin();
  strip.show();
  //need to wire up pin 32 of bt to pin 6 of attiny
  
  //check if bluetooth is paired(pin6 high), if so,light red, send begin signal to computer,
  //and continue, if not, blink red until paired
}
bool led = false;
void loop()
{
  //check the mode, one of 3
  if (mode ==0)
  {
    for (int i=0; i<6; i++)
    {
      if (led)
      {
        strip.setPixelColor(i,200,0,0);
      }
      else
      {
        strip.setPixelColor(i,0,0,0);
      }
    }
    strip.show();
    led = !led;
  }
  delay(200);
}