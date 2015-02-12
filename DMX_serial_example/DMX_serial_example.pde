import processing.serial.*;

Serial myPort;

void setDmxChannel(int channel, int value) {
  // Convert the parameters into a message of the form: 123c45w where 123 is the channel and 45 is the value
  // then send to the Arduino
  myPort.write( str(channel) + "c" + str(value) + "w" );
}


void setup() {
  println(Serial.list()); // shows available serial ports on the system
  // Change 0 to select the appropriate port as required.
  String portName = Serial.list()[7];
  myPort = new Serial(this, portName, 9600);

  size(700, 256);  // Create a window
}
  

void draw() {
  byte val = byte(255 * (mouseX/width));
  myPort.write(5);
  //setDmxChannel(1, val);
  delay(20);
}


