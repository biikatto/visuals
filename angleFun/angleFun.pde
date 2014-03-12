float stepSize = 0.01;
float phase = 0;
int center = 100;
float mag = 20;

void setup(){
	size(200,200,P2D);
}

void draw(){
	background(127);
	phase += stepSize;
	phase %= 1.0;
	println(phase);
	ellipse(mag*cos(phase*TAU)+center,mag*sin(phase*TAU)+center,20,20);
}
