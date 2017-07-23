/**
  NyARToolkit for proce55ing/1.2.0
  (c)2008-2012 nyatla
  airmail(at)ebony.plala.or.jp
  
  This program uses a PNG image instead of the patt file.
  The PNG image must be square form that includes edge.
*/
import processing.video.*;
import jp.nyatla.nyar4psg.*;

Capture cam;
MultiMarker nya;

void setup() {
  size(640,480,P3D);
  colorMode(RGB, 100);
  println(MultiMarker.VERSION);
  cam=new Capture(this,640,480);
  nya=new MultiMarker(this,width,height,"camera_para.dat",NyAR4PsgConfig.CONFIG_PSG);
  nya.addARMarker(loadImage("zekrom.png"),16,25,80);
  cam.start();
}

float x, y;
float frequency = 2;
float angle;
float radius = 60;

void draw()
{
  if (cam.available() !=true) {
      return;
  }
  cam.read();
  nya.detect(cam);
  background(0);
  nya.drawBackground(cam);
  if((!nya.isExist(0))){
    return;
  }
  nya.beginTransform(0);
  fill(0,0,255);
  lights();
  
  x = sin(radians(angle))*radius;
  y = cos(radians(angle))*radius;
  
  pushMatrix();
  sphere(20);
  popMatrix();
  
  
  translate(x, 0, y);
  sphere(10);
  angle += frequency;
  
 
  nya.endTransform();
}