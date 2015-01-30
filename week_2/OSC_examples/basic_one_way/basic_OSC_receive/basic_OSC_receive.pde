// Basic OSC : One way Send -> Receive (Receive side)

// These 2 things are needed to just receive OSC messages
import oscP5.*;
OscP5 oscP5;

int oscX, oscY; // Variables to store an incoming ints

void setup() {
  size(600, 600);    

  // Set up OSC to receive
  oscP5 = new OscP5(this, 6666); // New OSC object. Listening for OSC from sender on port 6666
}

void draw() {
  background(127);

  // Use the variables holding incoming OSC data
  ellipse(oscX, oscY, 50, 50);
}

// The oscEvent function is run when a new OSC message is received.
void oscEvent(OscMessage theOscMessage) {

  if (theOscMessage.checkAddrPattern("/xyPosition")) {

    // get(0).intValue() returns an int for the first received argument
    oscX = theOscMessage.get(0).intValue();

    // get(1).intValue() returns an int for the second received argument
    oscY = theOscMessage.get(1).intValue();
  }
}

