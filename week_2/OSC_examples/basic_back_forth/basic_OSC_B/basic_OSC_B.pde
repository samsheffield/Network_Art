// OSC Example: Two way Send <-> Receive (Side B)

// These libraries are needed to use UDP and OSC.
import oscP5.*;
import netP5.*;

// Main OSC object for sending, receiving, and parsing messages.
OscP5 oscP5;

// The object which handles communication with remote computer.
NetAddress remoteLocation;

// The object which holds an OSC message.
OscMessage myOSC;

// Variable to local arguments to send
int x, y, buttonState;

// Variables to hold any arguments from received OSC messages.
int oscX, oscY, oscButton;


void setup() {
  size(600, 600);

  // Set up OSC (Send & Receive)

  // IMPORTANT! Notice how these ports are flipped from Side A.
  oscP5 = new OscP5(this, 6666); // Start OSC, receive messages on port 6666 (INPUT)
  remoteLocation = new NetAddress("127.0.0.1", 5555); // IP Address and listening port to send messages to. "127.0.0.1" means localhost ("use this computer")
}

void draw() {
  background(127); 

  // Control something based on incoming data
  if (oscButton == 0) {
    fill(0);
  } else if (oscButton == 1) {
    fill(255);
  }
  ellipse(oscX, oscY, 50, 50);

  // Collect data to send via OSC
  // These two are redundant since they are already variables...
  x = mouseX;
  y = mouseY;

  if (mousePressed) {
    buttonState = 1;
  } else {
    buttonState = 0;
  }

  // Send OSC

  myOSC = new OscMessage("/xyPosition"); 

  // Messages are ordered like arrays. This is argument 0.
  myOSC.add(x);

  // This is argument 1.
  myOSC.add(y);

  // Send message 1
  oscP5.send(myOSC, remoteLocation);

  // Reuse myOSC to send another OSC message
  myOSC = new OscMessage("/buttonPress"); 
  myOSC.add(buttonState);

  // Send message 2
  oscP5.send(myOSC, remoteLocation);
}


// The oscEvent() function handles received OSC messages from Side B.
void oscEvent(OscMessage theOscMessage) {

  // Check to see if an incoming OSC message has the address "/sideB/mouse"
  if (theOscMessage.checkAddrPattern("/xyPosition")) {
    oscX = theOscMessage.get(0).intValue(); // If it matches, get the first value in the message (mouseX from Side B) and save it in oscX
    oscY = theOscMessage.get(1).intValue(); // If it matches, get the second value in the message (mouseY from Side B) and save it in oscY
  }
  // Parse a received message with the /buttonPress Address Pattern
  else if (theOscMessage.checkAddrPattern("/buttonPress")) {
    oscButton = theOscMessage.get(0).intValue();
  }
}

