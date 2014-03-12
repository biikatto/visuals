import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import oscP5.*; 
import netP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class john_whitney extends PApplet {

// john whitney inspired harmonic progression
// by Bruce Lott, march 2014

// doge

// import OSC libraries



OscP5 oscP5;

// computational variables
float degreeCount = 0; 
float rads;

// controllable parameters
float stpSize = 0.4f;  // rotation speed
float szScale = 0.5f;  // scale all circles 
float minNum = 0.2f;   // slowest/smallest circle
float maxNum = 10;    // fastest/biggest circle
float cWeight = 0.75f; // circles stroke weight
float ech = 0.1f;      // amount of visual echo
float bgHue = 0.4f;    //

public void setup(){
   size(displayWidth,displayHeight,P2D);
   if(frame!=null) frame.setResizable(true);
   colorMode(HSB, 1.0f);
   oscP5 = new OscP5(this,12000);
}

public void draw(){  
  // calculate angle
  degreeCount += stpSize;
  rads = radians(degreeCount);
  
  // setup frame
  strokeWeight(cWeight);
  fill(color(bgHue, 0.4f, 0.7f, ech));  
  noStroke(); 
  rect(0,0,width,height);
  
  translate(width/2.0f, height/2.0f);
  stroke(0);
  fill(color(0.2f, 0.4f, 0.7f));
  ellipse(0, 0, szScale*(width/2.0f), szScale*(width/2.0f));
  
  // draw the circles
  noFill();
  for(float i=minNum; i<maxNum; i=i+0.1f){
    ellipse(cos(rads*i*szScale)*100, sin(rads*i*szScale)*100, i*(width/10.0f)*szScale, -i*(width/10.0f)*szScale);
  }
}

public void oscEvent(OscMessage msg){
  if(msg.checkTypetag("f")==true){
    
    if(msg.checkAddrPattern("/min")==true){
      minimumNumber(msg.get(0).floatValue());
    }
    else if(msg.checkAddrPattern("/max")==true){
      maximumNumber(msg.get(0).floatValue());
    }
    else if(msg.checkAddrPattern("/size")==true){
      sizeScale(msg.get(0).floatValue());
    }
    else if(msg.checkAddrPattern("/speed")==true){
      speed(msg.get(0).floatValue());
    }
    else if(msg.checkAddrPattern("/cweight")==true){
      circleWeight(msg.get(0).floatValue());
    }
    
  }
}

public float minimumNumber(float m){
    minNum = unitClip(m)*10;
    println(minNum);
    return minNum;
}

public float maximumNumber(float m){
    maxNum = unitClip(m)*20;
    println(maxNum);
    return maxNum;
}

public float sizeScale(float s){
  szScale = unitClip(s);
  println(szScale);
  return szScale;
}

public float speed(float s){
  stpSize = unitClip(s)*2+0.0000000001f;
  println(stpSize);
  return stpSize; 
}

public float circleWeight(float cw){
  cWeight = unitClip(cw);
  println(cWeight);
  return cWeight; 
}



public float unitClip(float x){
  if(x<0) return 0.0f;
  else if(x>1) return 1.0f;
  else return x;
} 
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "john_whitney" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
