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
float stpSize = 0.7;  // rotation speed
float szScale = 0.5;  // scale all circles 
int minNum = 1;   // slowest/smallest circle
int maxNum = 10;    // fastest/biggest circle
float cWeight = 0.75; // circles stroke weight
float ech = 0.1;      // amount of visual echo
float bgHue = 0.4;    // background hue
float centHue = 0.2;// center circle hue
float circFillHue = 0.5;
float circFillOp = 0.15;
boolean forwards = false;

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
  fill(color((bgHue*rads*.08)%1, 0.8, 0.5, ech));  
  noStroke(); 
  rect(0,0,width,height);
  translate(width/2.0, height/2.0);
  stroke(0);
  
  // center circle
  fill(color((rads*0.25)%1, 0.7, 0.55, .7));
  ellipse(0, 0, szScale*(width/2.0), szScale*(width/2.0));
  
  // draw the circles
  noFill();
    if(forwards){
      for(int i=minNum; i<maxNum; i++){
        fill(color((circFillHue*rads*i*.5)%1.0, 0.7, 0.7, circFillOp));
        ellipse(cos(rads*i)*100, sin(rads*i)*100, i*(width/10.0)*szScale, -i*(width/10.0)*szScale);
      }
    }
    else{
      for(int i=maxNum; i>minNum; i--){
        fill(color((circFillHue*rads*i*.5)%1.0, 0.7, 0.7, circFillOp));
        ellipse(cos(rads*i)*100, sin(rads*i)*100, i*(width/10.0)*szScale, -i*(width/10.0)*szScale);
      }
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
    else if(msg.checkAddrPattern("/circop")==true){
      circleOpacity(msg.get(0).floatValue());
    }
  }
}

float circleOpacity(float o){
   circFillOp = unitClip(o);
   return circFillOp; 
}

float echoAmount(float e){
   ech = unitClip(e);
   return ech;
}
// parameters
int minimumNumber(float m){
    minNum = int(unitClip(m)*40+1);
    return minNum;
}

int maximumNumber(float m){
    maxNum = int(unitClip(m)*40+1);
    return maxNum;
}

float sizeScale(float s){
  szScale = unitClip(s);
  return szScale;
}

float speed(float s){
  stpSize = unitClip(s)+0.0000000001;
  return stpSize; 
}

float circleWeight(float cw){
  cWeight = unitClip(cw);
  return cWeight; 
}

float backgroundHue(float c){
  bgHue = unitClip(c);
  return bgHue;
}

float centerCircleHue(float c){
  centHue = unitClip(c);
  return centHue;
}

// utilities
float unitClip(float x){
  if(x<0) return 0.0;
  else if(x>1) return 1.0;
  else return x;
} 
