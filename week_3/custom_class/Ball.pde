// Class name should always be capitalized and match the name of the file
class Ball{

	// Declaring all properties (variables) that are specific to each object instance.
	float x, y, diameter, radius;
	color fillColor;

	// The object's constructor method (function). Think of this like setup().
	// This constructor takes temporary arguments which are used to set the object's properties.
	// The underscore in the names just makes it easy to recognize that these variables are temporary.
	Ball(float _x, float _y, float _diameter){
		x = _x;
		y = _y;
		diameter = _diameter;
		radius = diameter/2;
		fillColor = #FFFFFF;
	}

	// An object's functions are called methods.
	// This method was created to update the position of the object from the sketch's draw() loop.
	// If an object does not need to move, this method does not need to be called.
	void update(float _newX, float _newY){
		x = _newX;
		y = _newY;
	}

	// Method for drawing this object to the screen.
	void draw(){
		fill(fillColor);
		noStroke();
		ellipse(x, y, diameter, diameter);
	}

	// Method for testing collision with another Ball object.
	// A second Ball is given as an argument
	void hitTest(Ball _b){
		if(dist(x, y, _b.x, _b.y) < radius + _b.radius) {
			fillColor = #FFFF00;
		}
		else {
			fillColor = #FFFFFF;
		}
	}
}