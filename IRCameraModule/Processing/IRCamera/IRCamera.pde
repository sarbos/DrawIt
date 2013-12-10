import processing.serial.*;
Serial port;

int x1= 0;
int y1 =0;
int size1 = 0;

int x2= 0;
int y2 =0;
int size2 = 0;

void setup()
{
  size(1024,768);
  port = new Serial(this, "COM8", 9600);
  port.bufferUntil('\n');
}

void draw()
{
  background(0,0,0);
  fill(255,255,255);
  if (size1>0)
  ellipse(x1,y1,size1,size1);
  if (size2>0)
   ellipse(x2,y2,size2,size2);
  if (size1 >0 && size2>0)
  {
    stroke(0,255,0);
    line(x1,y1,x2,y2);
  }
}

void serialEvent (Serial port)
{
  String s = port.readString();
  s = trim(s);
  println(s);
  String[] coords =split(s, ',');
  if (coords.length>1)
  {
    x1 = Integer.parseInt(coords[1]);
    y1 = Integer.parseInt(coords[2]);
    size1 = Integer.parseInt(coords[3])*5;
  }
  else
  {
    size1=0;
    size2=0;
  }
  if (coords.length >4)
   {
    x2 = Integer.parseInt(coords[5]);
    y2 = Integer.parseInt(coords[6]);
    size2 = Integer.parseInt(coords[7])*5;
  }
  else 
  {
    size2=0;
  }
}
