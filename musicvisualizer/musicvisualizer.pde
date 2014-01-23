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
  
  myPort = new Serial(this,"COM4",9600);
  myPort.bufferUntil('\n');
}
void draw()
{
  rect(0,0,100,100);
  rect(100,0,100,100);
  rect(200,0,100,100);
  rect(300,0,100,100);
  rect(400,0,100,100);
  rect(500,0,100,100);

  int h=360;
  int s=100;
  int b=0;
  colorMode(HSB,360,100,8);
  
  if(beat.isRange(1,5,1))
  {
    color col = color(h,s,b+4);
    colorMode(RGB);
    fill(red(col),green(col),blue(col));
    send(red(col),green(col),blue(col));
    
  }
  if(beat.isRange(6,9,1))
  {
    color col = color(h,s,b+5);    
    colorMode(RGB);
    fill(red(col),green(col),blue(col));
    send(red(col),green(col),blue(col));
  }
  if(beat.isRange(10,15,1))
  {
    color col = color(h,s,b+6);
    colorMode(RGB);
    fill(red(col),green(col),blue(col));
    send(red(col),green(col),blue(col));
  }
  if(beat.isRange(16,20,1))
  {
    color col = color(h,s,b+7);
    colorMode(RGB);
    fill(red(col),green(col),blue(col));
    send(red(col),green(col),blue(col));
  }
  if(beat.isRange(21,26,1))
  {
    color col = color(h,s,b+8);
    colorMode(RGB);
    fill(red(col),green(col),blue(col));
    send(red(col),green(col),blue(col));
  }
  
}


void send(float r, float g, float b)
{
    if(myPort.available()>0) a=myPort.read()==97;
    if(a)
    {
      
      println(myPort.readString());
      myPort.write(byte(0xa5));
      myPort.write(byte(0xff));
      print(hex(byte(0x7f)));
      println("(" + int(r) + ", " + int(g) + ", " + int(b) + ")");
      myPort.write(byte(int(r)));
      myPort.write(byte(int(g)));
      myPort.write(byte(int(b)));
      a=false;
    }
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

