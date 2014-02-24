// OSC Server (Many -> One) example
// Based on oscP5broadcaster example by Andreas Schlegel

import oscP5.*;
import netP5.*;

OscP5 oscP5;
// Holds the IP addresses and ports of connected computers.
NetAddressList myNetAddressList = new NetAddressList();
int myListeningPort = 6666;
int myBroadcastPort = 5555;

int oscX1, oscY1, oscX2, oscY2;

Drop d1, d2;

void setup() {
  size(600, 600);
  oscP5 = new OscP5(this, myListeningPort);
  d1 = new Drop(100, 300, 50, 100, 2, 1);
  d2 = new Drop(300, 300, 30, 70, .5, 1);
}

void draw() {
  background(0);
  if (myNetAddressList.size() > 0) {
    d1.update(oscX1, oscY1);
    d1.draw();
  }
  if (myNetAddressList.size() > 1) {
    d2.update(oscX2, oscY2);
    d2.draw();
  }
}

void oscEvent(OscMessage theOscMessage) {

  // IMPORTANT: These are a little different from normal OSC message parsing!
  if (theOscMessage.checkAddrPattern("/server/connect")) {
    connect(theOscMessage.netAddress().address());
  }
  else if (theOscMessage.checkAddrPattern("/server/disconnect")) {
    disconnect(theOscMessage.netAddress().address());
  }
  // Check for incoming OSC messages from client 1
  else if (theOscMessage.checkAddrPattern("/positionXY1")) {
    oscX1 = theOscMessage.get(0).intValue();
    oscY1 = theOscMessage.get(1).intValue();
  }
  // Check for incoming OSC messages from client 2
  else if (theOscMessage.checkAddrPattern("/positionXY2")) {
    oscX2 = theOscMessage.get(0).intValue();
    oscY2 = theOscMessage.get(1).intValue();
  }
  else {
    oscP5.send(theOscMessage, myNetAddressList);
  }
}


private void connect(String theIPaddress) {
  if (!myNetAddressList.contains(theIPaddress, myBroadcastPort)) {
    myNetAddressList.add(new NetAddress(theIPaddress, myBroadcastPort));
    OscMessage m = new OscMessage("/clientID");
    m.add(myNetAddressList.list().size());
    oscP5.send(m, myNetAddressList.get(myNetAddressList.list().size()-1));
    println("### adding "+theIPaddress+" to the list.");
  } 
  else {
    println("### "+theIPaddress+" is already connected.");
  }
  println("### currently there are "+myNetAddressList.list().size()+" remote locations connected.");
}



private void disconnect(String theIPaddress) {
  if (myNetAddressList.contains(theIPaddress, myBroadcastPort)) {
    myNetAddressList.remove(theIPaddress, myBroadcastPort);
    println("### removing "+theIPaddress+" from the list.");
  } 
  else {
    println("### "+theIPaddress+" is not connected.");
  }
  println("### currently there are "+myNetAddressList.list().size());
}

