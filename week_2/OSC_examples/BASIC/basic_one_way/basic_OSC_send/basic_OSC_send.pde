// Basic OSC: One way Send -> Receive (Send side)

// These 4 things are needed for sending OSC messages
import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress remoteLocation;

// Used to hold our OSC messages
OscMessage myOSC;

void setup() {
    size(600, 600);

    // Set up OSC (Send & Receive)
    oscP5 = new OscP5(this, 5555); // Start OSC, listen on port 5555 (INPUT)
    remoteLocation = new NetAddress("127.0.0.1", 6666); // Receiving side's IP Address and listening port
}

void draw() {
    background(127); 

    myOSC = new OscMessage("/AmouseX"); // // Create an OSC message with a unique address called "/AmouseX"
    myOSC.add(mouseX); // Add data. Receiving side uses .get(0).intValue() to use this data
    oscP5.send(myOSC, remoteLocation); // Send OSC message
}