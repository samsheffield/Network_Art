
Ball ball1, ball2;	// Declare objects
boolean start;		// The start state. When this is true, ball1 will follow the mouse

void setup(){
	size(600,600);

	// Instantiate (create an instance of) objects with positioning and size arguments 
	ball1 = new Ball(200, height/2, 20);
	ball2 = new Ball(400, height/2, 200);
}

void draw(){
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


void mouseMoved(){
	start = true;
}