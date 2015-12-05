import cc.arduino.*;
import org.firmata.*;

import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;

Serial myPort;
String angle="";
String distance="";
String data="";
String noObject;
float pixsDistance;
int iAngle, iDistance;
int index1=0;
int index2=0;
int lines = 460;
PFont orcFont;

void setup() {
  
 size (960, 530);
 smooth();
 myPort = new Serial(this,"COM3", 9600);
 myPort.bufferUntil('.');
 orcFont = loadFont("AgencyFB-Reg-48.vlw");
}

void draw() {
  
  fill(98,245,31);
  textFont(orcFont);
  noStroke();
  fill(0,4); 
  rect(0, 0, width, 1010); 
  fill(98,245,31);
  drawRadar(); 
  drawLine();
  drawObject();
}

void serialEvent (Serial myPort) {
  data = myPort.readStringUntil('.');
  data = data.substring(0,data.length()-1);
  
  index1 = data.indexOf(",");
  angle= data.substring(0, index1);
  distance= data.substring(index1+1, data.length());
  
  iAngle = int(angle);
  iDistance = int(distance);
}

void drawRadar() {
  pushMatrix();
  translate(lines+20, lines+40);
  noFill();
  strokeWeight(2);
  stroke(98,245,31);
  arc(0,0,900,900,PI,TWO_PI);
  arc(0,0,600,600,PI,TWO_PI);
  arc(0,0,300,300,PI,TWO_PI);
  arc(0,0,100,100,PI,TWO_PI);
  // draws the angle lines
  line(-lines,0,lines,0);
  line(0,0,(-lines-20)*cos(radians(30)),(-lines-20)*sin(radians(30)));
  line(0,0,(-lines-20)*cos(radians(60)),(-lines-20)*sin(radians(60)));
  line(0,0,(-lines-20)*cos(radians(90)),(-lines-20)*sin(radians(90)));
  line(0,0,(-lines-20)*cos(radians(120)),(-lines-20)*sin(radians(120)));
  line(0,0,(-lines-20)*cos(radians(150)),(-lines-20)*sin(radians(150)));
  line((-lines-20)*cos(radians(30)),0,(-lines-20),0);
  popMatrix();
}

void drawObject() {
  pushMatrix();
  translate(lines+20,lines+40);
  strokeWeight(9);
  stroke(255,10,10); // red color
  pixsDistance = iDistance*12.2;
  if(iDistance<40){
    line(pixsDistance*cos(radians(iAngle)),-pixsDistance*sin(radians(iAngle)),(lines+10)*cos(radians(iAngle)),(-lines+10)*sin(radians(iAngle)));
  }
  popMatrix();
}

void drawLine() {
  pushMatrix();
  strokeWeight(9);
  stroke(30,250,60);
  translate(lines+20,lines+40);
  line(0,0,(lines)*cos(radians(iAngle)),(-lines)*sin(radians(iAngle)));
  popMatrix();
}