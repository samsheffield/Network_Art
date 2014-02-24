// OSC Example 02: Two way Send <-> Receive (Side A)

import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress remoteLocation;
OscMessage myOSC;

Thing thing1, thing2;

float oscX, oscY;
boolean started1, started2;

void setup() {
    size(600, 600);    

    oscP5 = new OscP5(this, 6666); // New OSC object, listen on this port (remoteLocation on other side)
    remoteLocation = new NetAddress("127.0.0.1", 5555); // The IP address and port being sent to (OUTPUT).
    thing1 = new Thing();
    thing2 = new Thing();
    noCursor();
}

void draw() {
    background(0);

    if (started1) { 
        thing1.update(mouseX, mouseY);
        thing1.draw();
    } 
    else {
        if (mouseX > 0 || mouseY > 0){
            started1 = true;
        }
    }

    if (started2) { 
        thing2.update(oscX, oscY);
        thing2.draw();
    } 
    else {
        if (oscX > 0 || oscY > 0) {
            started2 = true;
        }
    }

    myOSC = new OscMessage("/mouseXY"); 
    myOSC.add(mouseX); 
    myOSC.add(mouseY); 
    oscP5.send(myOSC, remoteLocation); 
}

void oscEvent(OscMessage theOscMessage) {
    if (theOscMessage.checkAddrPattern("/mouseXY")) {
        oscX = theOscMessage.get(0).intValue();
        oscY = theOscMessage.get(1).intValue();
    }
}
