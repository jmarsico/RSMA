import processing.serial.*;

//this will be the val we send to DMX
int val = 0;

Serial myPort;


void setDmxChannel(int channel, int value) {
  // Convert the parameters into a message of the form: 123c45w where 123 is the channel and 45 is the value
  // then send to the Arduino
  myPort.write( str(channel) + "c" + str(value) + "w" );
}

void setup() {
  size(640, 320);
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
  
}

void draw() {
  
  val = 255 * (mouseX/width);
  setDmxChannel(1, val);
  
}

