import oscP5.*;
import netP5.*;
import tsps.*;

import processing.serial.*;
import cc.arduino.*;



//TSPS tspsReceiver;  //initialize the TSPS object
Arduino arduino;    //initialize the Arduino object

void setup() {

  //set the size of the processing window
  size(1024, 768);

  //create the TSPS receiver
  //tspsReceiver= new TSPS(this);

  // Prints out the available serial ports.
  println(Arduino.list());

  // Modify this line, by changing the "0" to the index of the serial
  // port corresponding to your Arduino board (as it appears in the list
  // printed by the line above).
  arduino = new Arduino(this, Arduino.list()[7], 57600);
}

void draw() {
  background(0);

  // get array of people
  //TSPSPerson[] people = tspsReceiver.getPeopleArray();

  // loop through people
  //for (int i=0; i<people.length; i++) {
  //  // draw person!
  //  //people[i].draw();
  //  //println(i + ": " + people[i].centroid.y); //print the y location (0-1)
  //}

  //if there is more than one person
  //if (people.length > 0) {
  //  //get the y location of the person's centroid
  //  float firstPersXpos = people[0].centroid.y;
    
  //  //map the y location to a value between 0 and 255
  //  int pin5Val = int(map(firstPersXpos, 0, 1, 0, 255));
    
  //  //send that value to pin 5 of the arduino
  //  arduino.analogWrite(5, pin5Val);
  //  println("5: " + pin5Val);
  //}

  //if there is a second person in the frame
  //if (people.length > 1) {
  //  //get the y location of the person's centroid
  //  float secondPerXpos = people[1].centroid.y;
    
  //  //map the y location to a value between 0 and 255
  //  int pin6Val = int(map(secondPerXpos, 0, 1, 0, 255));
    
  //  //send that value to pin 6 of the arduino
  //  arduino.analogWrite(6, pin6Val);
  //  println("6: " + pin6Val);
  //}
}


// we can change the parameters of the frequency modulation Oscil
// in real-time using the mouse.
void oscEvent(OscMessage theOscMessage) {
  /* check if theOscMessage has the address pattern we are looking for. */

  if (theOscMessage.checkAddrPattern("/TSPS/personUpdated/")==true) {
    /* we will only look at the order ID (OID) */
    if (theOscMessage.get(1).intValue() == 0) {
      /* parse theOscMessage and extract the values from the osc message arguments. */
      float centroidX = theOscMessage.get(3).floatValue();  
      float centroidY = theOscMessage.get(4).floatValue();


      float modulateAmount = map( centroidX, 0, 1, 220, 1 );
      float modulateFrequency = map( centroidY, 0, 1, 0.1, 100 );

      fm.setFrequency( modulateFrequency );
      fm.setAmplitude( modulateAmount );
      return;
    }
  }
 else if(theOscMessage.checkAddrPattern("/TSPS/personEntered/")==true) {
   println("person entered!!!");
 } else if(theOscMessage.checkAddrPatter("/TSPS/personWillLeave/")==true)
 {
   //do something else
 }
}