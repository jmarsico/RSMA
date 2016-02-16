

/* based on frequency modulation example by Damien Di Fede
 
 A simple example for doing FM (frequency modulation) using two Oscils.
 For more information about Minim and additional features, 
 visit http://code.compartmental.net/minim/
 more information about oscP5 at website at http://www.sojamo.de/oscP5
 
 */

// import everything necessary to make sound and receive OSC messages.
import ddf.minim.*;
import ddf.minim.ugens.*;
import oscP5.*;

// create all of the variables that will need to be accessed in
// more than one methods (setup(), draw(), stop()).
Minim minim;
AudioOutput out;

//set up OSC objects
OscP5 osc;

// the Oscil we use for modulating frequency.
Oscil fm;

Oscil wave;

// variables to store the location0 of first person in TSPS (OID = 0)
PVector location0;
PVector location1;

// setup is run once at the beginning
void setup()
{
  // initialize the drawing window
  size( 512, 200, P3D );

  //setup osc object with (this, port)
  osc = new OscP5(this, 12000);

  // initialize the minim and out objects
  minim = new Minim( this );
  out   = minim.getLineOut();

  // make the Oscil we will hear.
  // arguments are frequency, amplitude, and waveform
  wave = new Oscil( 200, 0.8, Waves.SINE );
  // make the Oscil we will use to modulate the frequency of wave.
  // the frequency of this Oscil will determine how quickly the
  // frequency of wave changes and the amplitude determines how much.
  // since we are using the output of fm directly to set the frequency 
  // of wave, you can think of the amplitude as being expressed in Hz.
  fm   = new Oscil( 10, 2, Waves.SINE );
  // set the offset of fm so that it generates values centered around 200 Hz
  fm.offset.setLastValue( 200 );
  // patch it to the frequency of wave so it controls it
  fm.patch( wave.frequency );
  // and patch wave to the output
  wave.patch( out );
  
  location0 = new PVector(0,0);
  location1 = new PVector(0,0);
  
}

// draw is run many times
void draw()
{
  // erase the window to black
  background(255,0,0 );
  // draw using a white stroke
  stroke( 255 );
  // draw the waveforms
  for ( int i = 0; i < out.bufferSize() - 1; i++ ){
    // find the x position of each buffer value
    float x1  =  map( i, 0, out.bufferSize(), 0, width );
    float x2  =  map( i+1, 0, out.bufferSize(), 0, width );
    // draw a line from one buffer position to the next for both channels
    line( x1, 50 + out.left.get(i)*50, x2, 50 + out.left.get(i+1)*50);
    line( x1, 150 + out.right.get(i)*50, x2, 150 + out.right.get(i+1)*50);
  }  
  
  //map TSPS location0 (0-1) to our window
  float windowX0 = map(location0.x, 0., 1., 0., width);
  float windowY0= map(location0.x, 0., 1., 0., height);
  ellipse(windowX0,windowY0, 10, 10);
  
  float windowX1 = map(location1.x, 0., 1., 0., width);
  float windowY1= map(location1.x, 0., 1., 0., height);
  ellipse(windowX1,windowY1, 10, 10);
  
  text( "Modulation frequency: " + fm.frequency.getLastValue(), 5, 15 );
  text( "Modulation amplitude: " + fm.amplitude.getLastValue(), 5, 30 );
}

// we can change the parameters of the frequency modulation Oscil
// in real-time using the mouse.
void oscEvent(OscMessage theOscMessage) {
  /* check if theOscMessage has the address pattern we are looking for. */
  if(theOscMessage.checkAddrPattern("/TSPS/scene/") == true){
    println(theOscMessage);
    
  }
  

  if (theOscMessage.checkAddrPattern("/TSPS/personUpdated/")==true) {
    /* we will only look at the order ID (OID) */
    if (theOscMessage.get(1).intValue() == 0) {
      /* parse theOscMessage and extract the values from the osc message arguments. */
      location0.x = theOscMessage.get(3).floatValue();  
      location0.y = theOscMessage.get(4).floatValue();

      float modulateAmount = map( location0.x, 0, 1, 220, 1 );
      float modulateFrequency = map( location0.y, 0, 1, 0.1, 100 );

      fm.setFrequency( modulateFrequency );
      fm.setAmplitude( modulateAmount );
      return;
    }  
  }
 else if(theOscMessage.checkAddrPattern("/TSPS/personEntered/")==true) {
   println("person entered!!!");
   fill(200,150);
 } else if(theOscMessage.checkAddrPattern("/TSPS/personWillLeave/")==true){
   //do something else
   fm.setAmplitude(0.);
   fill(0);
   
 }
}

///////  TSPS OSC PROTOCOL! /////////
//0: pid;
//1: oid;
//2: age;
//3: centroid.x;
//4: centroid.y;
//5: velocity.x;
//6: velocity.y;
//7: depth;
//8: boundingRect.x;
//9: boundingRect.y;
//10: boundingRect.width;
//11: boundingRect.height;
//12: highest.x
//13: highest.y
//14: haarRect.x;           - will be 0 if hasHaar == false
//15: haarRect.y;           - will be 0 if hasHaar == false
//16: haarRect.width;       - will be 0 if hasHaar == false
//17: haarRect.height;      - will be 0 if hasHaar == false
//18: opticalFlowVectorAccumulation.x;
//19: opticalFlowVectorAccumulation.y;
//20+ : contours (if enabled)