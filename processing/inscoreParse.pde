/**
 * oscP5parsing by andreas schlegel
 * example shows how to parse incoming osc messages "by hand".
 * it is recommended to take a look at oscP5plug for an
 * alternative and more convenient way to parse messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

int chordDuration;

void setup() {
  size(400,400);
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 12000 */
  
  oscP5 = new OscP5(this,12000);
  
  myRemoteLocation = new NetAddress("127.0.0.1",7000);
}

void draw() {
  background(0);  
}


void mousePressed() {
  /* create a new osc message object */
  
  // /ITL/scene/* del
  
  
  OscMessage myMessage = new OscMessage("/ITL/scene/guidostream");
  
  /*
  myMessage.add("set");
  myMessage.add("gmn");
  */
  
  myMessage.add("write");
  
  myMessage.add(" {a,c,e} ");
  
  oscP5.send(myMessage, myRemoteLocation); 
  
}


void oscEvent(OscMessage theOscMessage) {
  /* check if theOscMessage has the address pattern we are looking for. */
  
  print("algo llega");
  println("### received an osc message. with address pattern "+theOscMessage);
  
  if(theOscMessage.checkAddrPattern("/chordPitch")==true) {
            
      String firstValue = theOscMessage.get(0).stringValue();  
      String secondValue = theOscMessage.get(1).stringValue();
      String thirdValue = theOscMessage.get(2).stringValue();
      
      println(" values: "+firstValue+", "+secondValue+", "+thirdValue);
      
      OscMessage myMessage = new OscMessage("/ITL/scene/guidostream");
      
      /*
      myMessage.add("set");
      myMessage.add("gmn");
      */
      
      myMessage.add("write");
      
      //String aux = "[ {" + firstValue + "," + secondValue + "," + thirdValue + "} ]";
      
      String aux = "{" + firstValue + "," + secondValue + "," + thirdValue + "}";
      
      print(aux);
      myMessage.add(aux);
  
      oscP5.send(myMessage, myRemoteLocation); 
  } 
  
  

  
  return;
}
