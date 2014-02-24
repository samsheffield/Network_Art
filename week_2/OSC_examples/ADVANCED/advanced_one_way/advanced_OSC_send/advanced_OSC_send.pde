// OSC Example 01: One way Send -> Receive (Send side)

// These 4 things are needed for sending OSC messages
import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress remoteLocation;

// Used to hold our OSC messages
OscMessage myOSC;

Thing thing1;

boolean started; // Don't collect mouse input unless in screen
int button;

void setup() {
    size(600, 600);

    // Set up OSC (Send & Receive)
    oscP5 = new OscP5(this, 5555); // Start OSC, listen on this port (INPUT)
    remoteLocation = new NetAddress("127.0.0.1", 6666); // The IP address and port being sent to (OUTPUT).

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
        thing1.update(mouseX, mouseY);
        thing1.draw();
    } 
    else {
        if (mouseX > 0 || mouseY > 0){
            started = true;
        }
    }

    myOSC = new OscMessage("/mouseXY"); // New message with address
    myOSC.add(mouseX); // Add something to send
    myOSC.add(mouseY); // Add something else to send
    oscP5.send(myOSC, remoteLocation); // Send OSC message

    if (mousePressed){
        button = 1;
    }
    else{
        button = 0;
    }

    myOSC = new OscMessage("/buttonPress"); // Reuse message with new address
    myOSC.add(button); // Add something to send
    oscP5.send(myOSC, remoteLocation); // Send OSC message
}