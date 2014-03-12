// john whitney inspired harmonic progression
// by Bruce Lott, march 2014

// osc
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
float bgHue = 0.4;    // background hue
float centHue = 0.2;// center circle hue
float circFillHue = 0.5;
float circFillOp = 0.2;

void setup(){
   size(500,500,P2D);
   if(frame!=null) frame.setResizable(true);
   else size(displayWidth, displayHeight, P2D);
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
  
  // center circle
  fill(color(rads%1, 0.4, 0.7, .7));
  ellipse(0, 0, szScale*(width/2.0), szScale*(width/2.0));
  
  // draw the circles
  noFill();
  for(float i=minNum; i<maxNum; i=i+0.1){
    fill(color((circFillHue*rads*i)%1.0, 0.4, 0.7, circFillOp));
    ellipse(cos(rads*i*szScale)*100, sin(rads*i*szScale)*100, i*(width/10.0)*szScale, -i*(width/10.0)*szScale);
  }
}

// osc handler
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
    else if(msg.checkAddrPattern("/bghue")==true){
      backgroundHue(msg.get(0).floatValue());
    }
    else if(msg.checkAddrPattern("/centhue")==true){
      centerCircleHue(msg.get(0).floatValue());
    }
    else if(msg.checkAddrPattern("/echo")==true){
      echoAmount(msg.get(0).floatValue());
    }
  }
}
float echoAmount(float e){
   ech = unitClip(e);
   println(ech);
   return ech;
}
// parameters
float minimumNumber(float m){
    minNum = unitClip(m);
    println(minNum);
    return minNum;
}

float maximumNumber(float m){
    maxNum = unitClip(m)*5;
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

float backgroundHue(float c){
  bgHue = unitClip(c);
  println(bgHue);
  return bgHue;
}

float centerCircleHue(float c){
  centHue = unitClip(c);
  println(centHue);
  return centHue;
}

// utilities
float unitClip(float x){
  if(x<0) return 0.0;
  else if(x>1) return 1.0;
  else return x;
} 
