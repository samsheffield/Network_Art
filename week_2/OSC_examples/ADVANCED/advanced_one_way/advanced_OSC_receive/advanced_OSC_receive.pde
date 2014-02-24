// OSC Example 01: One way Send -> Receive (Receive side)

// These 2 things are needed to receive OSC messages
import oscP5.*;
OscP5 oscP5;

Thing thing1;

float oscX, oscY;
boolean started;
int button;

void setup() {
    size(600, 600);    

    // SET UP OSC
    oscP5 = new OscP5(this, 6666); // New OSC object, listen on this port (remoteLocation on other side)

    thing1 = new Thing();
}

void draw() {
    if(button == 1){
        background(128);
    }
    else{
        background(0);
    }

    if (started) { 
        noCursor();
        thing1.update(oscX, oscY);
        thing1.draw();
    } 
    else {
        if (oscX > 0 || oscY > 0){
            started = true;
        }
    }
}

// The oscEvent function is run when a new OSC message is received.
void oscEvent(OscMessage theOscMessage) {

    // An if statement can be used to parse the incoming messages by looking for a matching address
    if (theOscMessage.checkAddrPattern("/mouseXY")) {
        
        // The data will be formatted similarly to an array (beginning with a 0 index). 
        // intValue is used to deal with an incoming int. there is a corresponding floatValue() for float values.
        oscX = theOscMessage.get(0).intValue();
        oscY = theOscMessage.get(1).intValue();
    }
    // And another...
    else if (theOscMessage.checkAddrPattern("/buttonPress")) {
        button = theOscMessage.get(0).intValue();
        println(button);
    }
}
