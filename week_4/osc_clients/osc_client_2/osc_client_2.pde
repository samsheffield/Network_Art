// OSC Client
// Code based on oscP5broadcastClient example by Andreas Schlegel
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress serverLocation; 
OscMessage myOscMessage;

int clientID; // Each client is assigned a unique number based on the order in which they connected
Marker m1; // Something to display

void setup() {
  size(600, 600);
  oscP5 = new OscP5(this, 5555); // Listening
  serverLocation = new NetAddress("127.0.0.1", 6666); // Sending
  m1 = new Marker(300, 300, 40, 40); // Set up marker
}

void draw() {
  // Change background color based on connection
  if(clientID == 0)
    background(#FF0000);
  else
    background(#00FF00);
  m1.draw();
}

// Position marker and send OSC message to server
void mousePressed(){
  m1.update(mouseX, mouseY);
  myOscMessage = new OscMessage("/positionXY" + clientID); // Address pattern is created dynamically using clientID
  myOscMessage.add(mouseX);
  myOscMessage.add(mouseY);
  oscP5.send(myOscMessage, serverLocation);
}

// Use keys to connect or disconnect
void keyPressed() {
  OscMessage serverMessage;

  // Connect with 'c'
  if(key == 'c' || key == 'C'){
    serverMessage = new OscMessage("/server/connect",new Object[0]);
    oscP5.flush(serverMessage, serverLocation);  
  }
  // Disconnect with 'd'
  else if(key == 'd' || key == 'D'){
    serverMessage = new OscMessage("/server/disconnect",new Object[0]);
    oscP5.flush(serverMessage, serverLocation);  
    clientID = 0; // Reset clientID to change background color
  } 
}

// Parse incoming OSC messages
void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/clientID")) {
    clientID = theOscMessage.get(0).intValue(); // Receive clientID from server upon connecting
  }
}