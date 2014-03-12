// john whitney inspired harmonic progression
// by Bruce Lott, march 2014

// doge

// import OSC libraries
import oscP5.*;
import netP5.*;

OscP5 oscP5;

// computational variables
float degreeCount = 0; 
float rads;

// controllable parameters
float stpSize = 0.4;  // rotation speed
float szScale = 0.5;  // scale all circles 
float minNum = 0.2;   // slowest/smallest circle
float maxNum = 10;    // fastest/biggest circle
float cWeight = 0.75; // circles stroke weight
float ech = 0.1;      // amount of visual echo
float bgHue = 0.4;    //

void setup(){
   size(500, 500, P2D);
   if(frame!=null) frame.setResizable(true);
   else size(displayWidth,displayHeight);
   colorMode(HSB, 1.0);
   oscP5 = new OscP5(this,12000);
}

void draw(){  
  // calculate angle
  degreeCount += stpSize;
  rads = radians(degreeCount);
  
  // setup frame
  strokeWeight(cWeight);
  fill(color(bgHue, 0.4, 0.7, ech));  
  noStroke(); 
  rect(0,0,width,height);
  
  translate(width/2.0, height/2.0);
  stroke(0);
  fill(color(0.2, 0.4, 0.7));
  ellipse(0, 0, szScale*(width/2.0), szScale*(width/2.0));
  
  // draw the circles
  noFill();
  for(float i=minNum; i<maxNum; i=i+0.1){
    ellipse(cos(rads*i*szScale)*100, sin(rads*i*szScale)*100, i*(width/10.0)*szScale, -i*(width/10.0)*szScale);
  }
}

void oscEvent(OscMessage msg){
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

float minimumNumber(float m){
    minNum = unitClip(m)*10;
    println(minNum);
    return minNum;
}

float maximumNumber(float m){
    maxNum = unitClip(m)*20;
    println(maxNum);
    return maxNum;
}

float sizeScale(float s){
  szScale = unitClip(s);
  println(szScale);
  return szScale;
}

float speed(float s){
  stpSize = unitClip(s)*2+0.0000000001;
  println(stpSize);
  return stpSize; 
}

float circleWeight(float cw){
  cWeight = unitClip(cw);
  println(cWeight);
  return cWeight; 
}



float unitClip(float x){
  if(x<0) return 0.0;
  else if(x>1) return 1.0;
  else return x;
} 
