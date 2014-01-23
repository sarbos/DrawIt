import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import processing.serial.*;
import ddf.minim.*;
import java.lang.Object;
import java.awt.Color;
Minim minim;
AudioPlayer song;
BeatDetect beat;
BeatListener bl;
Serial myPort;
boolean a=true;

void setup()
{
  size(640, 480);
  // always start Minim before you do anything with it
  minim = new Minim(this);
  frameRate( 30 );
  smooth();
  song = minim.loadFile("wayward.mp3", 2048);
 
  beat = new BeatDetect(song.bufferSize(), song.sampleRate());
 
  beat.setSensitivity(0);
  bl = new BeatListener(beat, song); 
 
  song.play();
  //noStroke();
  
  //myPort = new Serial(this,"COM4",9600);
}
void draw()
{
  //size(501,100);
  //background(0,0,0);
  rect(0,0,100,100);
  rect(100,0,100,100);
  rect(200,0,100,100);
  rect(300,0,100,100);
  rect(400,0,100,100);
  rect(500,0,100,100);
  
  boolean kick = beat.isKick();
  boolean hat = beat.isHat();
  boolean snare = beat.isSnare();
  ArrayList colors = new ArrayList();
  //color col = color(255,random(100),random(255));
  if(kick)
  {
    //color col = color(random(100),random(255),255);
//fill(col);
  }
  if(snare)
  {
    //color col = color(255,random(100),random(255));
    //fill(col);
  }
  if(hat)
  {
    //colorMode(HSB, 360, 100, 100);
    //color col = color(random(180),76,91);
    //color col = color(random(10),random(5),random(2));
    //color col = color(random(100),random(255),255);
    //fill(col);
    //fill(color(0,0,255));
  }
  int h=180;
  int s=100;
  int b=0;
  colorMode(HSB,360,100,8);
  int r=0;
  int g=0;
//  int b=0;
  Color jCol = new Color(0,0,0);
  if(beat.isRange(1,5,1))
  {
    //color col = color(h,s,80);
    //color col = color(h,s,b+4);
    
    //int coli=jCol.HSBtoRGB(h,s,b);
    convertColor(jCol, h, s, b+4);
    send(h, s, 100);
  }
  if(beat.isRange(6,9,1))
  {
    //color col = color(h,s,b+5);
    convertColor(jCol, h, s, b+5);
    send(h, s, 100);
  }
  if(beat.isRange(10,15,1))
  {
    //color col = color(h,s,b+6);
    convertColor(jCol, h, s, b+6);
    send(h, s, 100);
  }
  if(beat.isRange(16,20,1))
  {
    //color col = color(h,s,b+7);
    convertColor(jCol, h, s, b+7);
    send(h, s, 100);
  }
  if(beat.isRange(20,26,1))
  {
    //color col = color(h,s,b+8);
    convertColor(jCol, h, s, b+8);
    send(int(random(255)),int(random(255)),int(random(255)));
  }
  
}

void convertColor(Color jCol, int h, int s, int b)
{
    Color hsbCol=jCol.getHSBColor(h,s,b);
    colorMode(RGB);
    color col = color(hsbCol.getRed(),hsbCol.getBlue(),hsbCol.getGreen());
    fill(col);
}

void send(int h, int s, int v)
{
  /*
    //int colb = Color.HSBtoRGB(h, s, v);
    //color col = HSL2RGB((float)h, (float)s / 100f, (float)v / 100f);
    //byte r = byte(red(col));
    //byte g = byte(green(col));
    //byte b = byte(blue(col));
    byte r=byte(0);
    byte g=byte(0);
    byte b=byte(255);
    if(myPort.available()>0) a=myPort.read()=='a';
    if(a)
    {
      myPort.write(byte(0x7f));
      print(hex(byte(0x7f)));
      println("(" + hex(r) + ", " + hex(g) + ", " + hex(b) + ")");
      myPort.write(r);
      myPort.write(g);
      myPort.write(b);
      a=false;
      delay(700);
      //colorMode(RGB);
    //fill(col);
    //delay(150);
    }
    //colorMode(RGB);
    //fill(col2);
    
    
    
    //color col = color(h,s,v);
    //fill(col);*/
}

void stop()
{
  // always close Minim audio classes when you are done with them
  song.close();
  minim.stop();
 
  super.stop();
}
 
class BeatListener implements AudioListener
{
  private BeatDetect beat;
  private AudioPlayer source;
 
  BeatListener(BeatDetect beat, AudioPlayer source)
  {
    this.source = source;
    this.source.addListener(this);
    this.beat = beat;
  }
 
  void samples(float[] samps)
  {
    beat.detect(source.mix);
  }
 
  void samples(float[] sampsL, float[] sampsR)
  {
    beat.detect(source.mix);
  }
}

