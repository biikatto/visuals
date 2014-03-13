import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class angleFun extends PApplet {

float stepSize = 0.01f;
float phase = 0;
int center = 100;
float mag = 20;

public void setup(){
	size(200,200,P2D);
}

public void draw(){
	background(127);
	phase += stepSize;
	phase %= 1.0f;
	println(phase);
	ellipse(mag*cos(phase*TAU)+center,mag*sin(phase*TAU)+center,20,20);
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "angleFun" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
