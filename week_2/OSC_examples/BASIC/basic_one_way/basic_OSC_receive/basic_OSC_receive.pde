// Basic OSC : One way Send -> Receive (Receive side)

// These 2 things are needed to just receive OSC messages
import oscP5.*;
OscP5 oscP5;

int oscX; // A variable to store an incoming int

void setup() {
    size(600, 600);    

    // Set up OSC to receive
    oscP5 = new OscP5(this, 6666); // New OSC object. Listening for OSC from sender on port 6666
}

void draw() {
    background(127);

    // Use the variable holding incoming OSC data
    ellipse(oscX, height/2, 50, 50);
}

// The oscEvent function is run when a new OSC message is received.
void oscEvent(OscMessage theOscMessage) {

    // Check to see if OSC message address is "/AmouseX". Any messages received which do not match address pattern are ignored!    
    if (theOscMessage.checkAddrPattern("/AmouseX")) {
        
        // The data is formatted like an array (beginning with a 0 index). 
        // intValue is used to deal with an incoming int. there is a corresponding floatValue() for float values.
        oscX = theOscMessage.get(0).intValue();
    }
}