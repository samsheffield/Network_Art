// Position marker
// Draws a +

class Marker{
	float x, y, w, h;

	Marker(float _x, float _y, float _w, float _h){
		x = _x;
		y = _y;
		w = _w;
		h = _h;
	}

	void update(float _x, float _y){
		x = _x;
		y = _y;
	}

	void draw(){
		pushMatrix();
		translate(x, y);
		line(-w/2, 0, w/2, 0);
		line(0, -h/2, 0, h/2);
		popMatrix();
	}
}