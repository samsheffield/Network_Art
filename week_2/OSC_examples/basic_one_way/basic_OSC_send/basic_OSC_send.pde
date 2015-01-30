// Basic OSC: One way Send -> Receive (Send side)

// These libraries are needed to use UDP and OSC.
import oscP5.*;
import netP5.*;

// Main OSC object for sending, receiving, and parsing messages.
OscP5 oscP5;

// The object which handles communication with remote computer.
NetAddress remoteLocation;

// The object which holds an OSC message.
OscMessage myOSC;

// Variables to hold any arguments from received OSC messages.
int oscX, oscY, oscButton;

void setup() {
  size(600, 600);

  // Set up OSC (Send & Receive)
  oscP5 = new OscP5(this, 5555); // Start OSC, listen on port 5555 (INPUT)
  remoteLocation = new NetAddress("127.0.0.1", 6666); // Receiving side's IP Address and listening port. "127.0.0.1" means localhost ("use this computer")
}

void draw() {
  background(127); 

  myOSC = new OscMessage("/xyPosition"); 

  // Messages are ordered like arrays. This is argument 0.
  myOSC.add(mouseX);

  // This is argument 1.
  myOSC.add(mouseY);

  // Send OSC message when finished adding arguments.
  oscP5.send(myOSC, remoteLocation);
}

