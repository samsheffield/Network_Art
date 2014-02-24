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

public class custom_class extends PApplet {


Ball ball1, ball2;	// Declare objects
boolean start;		// The start state. When this is true, ball1 will follow the mouse

public void setup(){
	size(600,600);

	// Instantiate (create an instance of) objects with positioning and size arguments 
	ball1 = new Ball(200, height/2, 20);
	ball2 = new Ball(400, height/2, 200);
}

public void draw(){
	background(0);

	if(start == true){
		// Set ball1 position to mouse position
		ball1.update(mouseX, mouseY);
		// ball2 will not move, so it is not necessary to use its update method
	}

	// Check for collision
	ball1.hitTest(ball2);
	ball2.hitTest(ball1);

	// Draw balls
	ball1.draw();
	ball2.draw();
}


public void mouseMoved(){
	start = true;
}
// Class name should always be capitalized and match the name of the file
class Ball{

	// Declaring all properties (variables) that are specific to each object instance.
	float x, y, diameter, radius;
	int fillColor;

	// The object's constructor method (function). Think of this like setup().
	// This constructor takes temporary arguments which are used to set the object's properties.
	// The underscore in the names just makes it easy to recognize that these variables are temporary.
	Ball(float _x, float _y, float _diameter){
		x = _x;
		y = _y;
		diameter = _diameter;
		radius = diameter/2;
		fillColor = 0xffFFFFFF;
	}

	// An object's functions are called methods.
	// This method was created to update the position of the object from the sketch's draw() loop.
	// If an object does not need to move, this method does not need to be called.
	public void update(float _newX, float _newY){
		x = _newX;
		y = _newY;
	}

	// Method for drawing this object to the screen.
	public void draw(){
		fill(fillColor);
		noStroke();
		ellipse(x, y, diameter, diameter);
	}

	// Method for testing collision with another Ball object.
	// A second Ball is given as an argument
	public void hitTest(Ball _b){
		if(dist(x, y, _b.x, _b.y) < radius + _b.radius) {
			fillColor = 0xffFFFF00;
		}
		else {
			fillColor = 0xffFFFFFF;
		}
	}
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "custom_class" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
