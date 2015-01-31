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

// Local variables to send
int x, y;

void setup() {
  size(600, 600);

  // Set up OSC (Send & Receive)
  oscP5 = new OscP5(this, 5555); // Start OSC, listen on port 5555 (INPUT)
  remoteLocation = new NetAddress("127.0.0.1", 6666); // Receiving side's IP Address and listening port. "127.0.0.1" means localhost ("use this computer")
}

void draw() {
  background(127); 
  
  x = mouseX;
  y = mouseY;
  
  // Create an OSC message and send it
  myOSC = new OscMessage("/xyPosition"); // The message address is /xyPosition
  
  myOSC.add(x); // Messages are ordered like arrays. This is argument 0.
  myOSC.add(y); // This is argument 1.
  
  oscP5.send(myOSC, remoteLocation); // Send OSC message when finished adding arguments.
}

