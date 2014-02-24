// A class to draw something on the screen

class Thing {
	float x, y, w, h;

	Thing(){
		w = 50;
		h = 50;

		// Start offscreen
		x = -w;
		y = -h;
	}

	void update(float _x, float _y){
		x = _x;
		y = _y;
	}

	void draw(){
		noFill();
		stroke(255);
		strokeWeight(3);
		ellipse(x, y, w, h);
	}
}