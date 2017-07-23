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
float angle2 = angle;
float defaultRadius = 60;
float orbitHeight = 0;
float orbitMax = 50;

boolean orbitRising = true;

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
  
  lights();
  noStroke();
  
  x = sin(radians(angle))*defaultRadius;
  y = cos(radians(angle))*defaultRadius;
  
  buildSun();
  
  buildDefaultOrbitPlanet();
  
  buildWackyOrbitPlanet();
  
  buildPlanetWithObliqueOrbit();
  
  nya.endTransform();
}

void buildSun() {
  pushMatrix();
  fill(255, 204, 0);
  texture(sunTexture);
  sphere(20);
  popMatrix();
}

void buildDefaultOrbitPlanet() {
  pushMatrix();
  translate(x, 0, y);
  fill(77, 148, 255);
  sphere(10);
  angle += frequency;
  popMatrix();
}

void buildWackyOrbitPlanet() {
  pushMatrix();
  float x2 = sin(radians(angle2))*defaultRadius ;
  float y2 = cos(radians(angle2))*defaultRadius ;
  translate(x2, 0, y2);
  fill(200, 148, 255);
  sphere(6);
  angle2 += frequency + 3;
  popMatrix();
}

void buildPlanetWithObliqueOrbit() {
  pushMatrix();
  fill(172, 57, 57);
  translate(x + 30, orbitHeight, y + 30);
  sphere(5);
  angle += frequency;
  orbitRisesAndFalls();
  popMatrix();
}

void orbitRisesAndFalls() {
  if(orbitRising == true && orbitHeight < orbitMax) {
    orbitHeight +=frequency;
  }
  if(orbitRising == true && orbitHeight == orbitMax) {
    orbitRising = false;
    orbitHeight -=frequency;
  }
  
  if(orbitRising == false && orbitHeight > -orbitMax) {
    orbitHeight -=frequency;
  }
  if(orbitRising == false && orbitHeight == -orbitMax) {
    orbitRising = true;
    orbitHeight +=frequency;
  }
}