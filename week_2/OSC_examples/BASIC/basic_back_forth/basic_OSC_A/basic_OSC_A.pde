// Basic OSC Example: Two way Send <-> Receive (Side A)

import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress remoteLocation;
OscMessage myOSC;

// These oscX and oscY variables store data from Side B
float oscXB, oscYB;

void setup() {
    size(600, 600);    

    oscP5 = new OscP5(this, 6666); // New OSC object. Listening on port 6666
    remoteLocation = new NetAddress("127.0.0.1", 5555); // Side B's IP Address and listening port
    noCursor();
}

void draw() {
    background(0);

    // Position controlled by Side A user
    ellipse(mouseX, mouseY, 50, 50);

    // Position controlled by OSC
    ellipse(oscXB, oscYB, 50, 50);
    
    myOSC = new OscMessage("/AmouseXY"); // Create an OSC message with a unique address called "/AmouseXY"
    myOSC.add(mouseX); // Add data. Side B uses .get(0).intValue() to use this data
    myOSC.add(mouseY); // Add data. Side B uses .get(1).intValue() to use this data
    oscP5.send(myOSC, remoteLocation); // Send OSC message
}

// The oscEvent() function handles received OSC messages from Side B.
void oscEvent(OscMessage theOscMessage) {

    // Check to see if an incoming OSC message has the address "/BmouseXY"
    if (theOscMessage.checkAddrPattern("/BmouseXY")) {
        oscXB = theOscMessage.get(0).intValue(); // If it matches, get the first value in the message (mouseX from Side B) and save it in oscX
        oscYB = theOscMessage.get(1).intValue(); // If it matches, get the second value in the message (mouseY from Side B) and save it in oscY
    }
}