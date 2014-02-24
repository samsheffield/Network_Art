// Basic OSC Example: Two way Send <-> Receive (Side B)

import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress remoteLocation;
OscMessage myOSC;

// These oscX and oscY variables store data from Side A
float oscXA, oscYA;

void setup() {
    size(600, 600);    

    // Note: these ports are switched from Side A
    oscP5 = new OscP5(this, 5555); // Listening on port 5555
    remoteLocation = new NetAddress("127.0.0.1", 6666); // Sending to Side A on port 6666
    noCursor();
}

void draw() {
    background(0);

    // Position controlled by OSC
    ellipse(oscXA, oscYA, 50, 50);
    
    // Position controlled by Side A user
    ellipse(mouseX, mouseY, 50, 50);
    
    myOSC = new OscMessage("/BmouseXY"); // Create an OSC message with a unique address called "/mouseXY"
    myOSC.add(mouseX); // Add data. Side A uses .get(0).intValue() to use this data
    myOSC.add(mouseY); // Add data. Side A uses .get(0).intValue() to use this data
    oscP5.send(myOSC, remoteLocation); // Send OSC message
}

// The oscEvent() function handles received OSC messages from Side A.
void oscEvent(OscMessage theOscMessage) {

    // Check to see if an incoming OSC message has the address "/AmouseXY"
    if (theOscMessage.checkAddrPattern("/AmouseXY")) {
        oscXA = theOscMessage.get(0).intValue(); // If it matches, get the first value in the message (mouseX from Side B) and save it in oscX
        oscYA = theOscMessage.get(1).intValue(); // If it matches, get the second value in the message (mouseY from Side B) and save it in oscY
    }
}