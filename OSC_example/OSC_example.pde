/**
 * oscP5message by andreas schlegel
 * example shows how to create osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */
 
import oscP5.*;
import netP5.*;

String myName = "Jake";

OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(400,400);
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,12000);
  
  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  myRemoteLocation = new NetAddress("127.0.0.1",12000);
}


void draw() {
  background(0);  
  
}

void mouseMoved() {
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessage = new OscMessage("/test");
  
  //add an int argument for mouseX and mouseY
  myMessage.add(mouseX); /* add an int to the osc message */
  myMessage.add(mouseY); /* add a float to the osc message */
  
  //convert mouseX and mouseY into percentage of screen and add those float arguments
  float xPercent = (1.0 - (width - mouseX ) / float(width));
  float yPercent = (1.0 - (width - mouseY ) / float(height));
  myMessage.add(xPercent);
  myMessage.add(yPercent);
  
  //add your name to the end!
  myMessage.add(myName); /* add a string to the osc message */

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation); 
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  //println(theOscMessage.addrPattern());
  if(theOscMessage.addrPattern() == "/test")
  {
    int intX = theOscMessage.get(0).intValue();  
    int intY = theOscMessage.get(1).intValue();
    float floatX = theOscMessage.get(2).floatValue();
    float floatY = theOscMessage.get(3).floatValue();
    String name = theOscMessage.get(4).stringValue();
    println("intX: " + intX + " intY: " + intY + " | floatX: " + floatX + " floatY: " + floatY);
  }
}
