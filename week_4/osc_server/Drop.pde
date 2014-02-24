// Spinning shapes
// id 0 draws an ellipse, id 1 draws a rect

class Drop{
	int id;
	float x, y, w, h, angle, r;

	Drop(float _x, float _y, float _w, float _h, float _r, int _id){
		x = _x;
		y = _y;
		w = _w;
		h = _h;
		r = _r;
		id = _id;
	}

	void update(float _x, float _y){
		x = _x;
		y = _y;
		angle += r;
	}

	void draw(){
		noFill();
		stroke(255);

		pushMatrix();
		translate(x, y);
		rotate(radians(angle));

		if(id == 0){
			ellipse(0, 0, w, h);
		}
		else if(id == 1){
			rectMode(CENTER);
			rect(0, 0, w, h);
			rectMode(CORNER);
		}
		
		popMatrix();
	}
}