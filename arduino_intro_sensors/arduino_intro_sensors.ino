int potLED = 10;
int pot = 0;

int photoLED = 3;
int photoRes = 1;

int pressureLED = 5;
int pressure = 2;

int micLED = 6;
int mic = 3;
const int numReadings = 100;
int readings[numReadings];      // the readings from the analog input
int readIndex = 0;              // the index of the current reading
int total = 0;                  // the running total
int average = 0;                // the average

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(potLED, OUTPUT);
  pinMode(photoLED, OUTPUT);
  pinMode(pressureLED, OUTPUT);

  //zero out the array for our running average
  for (int i = 0; i < numReadings; i++) {
    readings[i] = 0;
  }
}


void loop() {
////////////// POTENTIOMETER /////////////////////
  int potVal = analogRead(pot);
  analogWrite(potLED,map(potVal, 0, 1023, 0, 255));
//  Serial.print("Potentiometer: ");
//  Serial.println(potVal);


////////////// PHOTO RESISTOR /////////////////////
  int photoVal = analogRead(photoRes);
  photoVal = constrain(photoVal, 700, 1000);
  analogWrite(photoLED, map(photoVal, 700, 1000, 0, 255));
//  Serial.print("Photoresistor: ");
//  Serial.println(photoVal);

////////////// PRESSURE SENSOR ///////////////////// 
  int pressureVal = analogRead(pressure);
  analogWrite(pressureLED,map(pressureVal, 0, 1023, 0, 255));
//  Serial.print("Pressure: ");
//  Serial.println(pressureVal);


  ////////////// MICROPHONE /////////////////////
  int micVal = analogRead(mic);
  micVal = constrain(micVal, 50, 900);

  //RUNNING AVERAGE
  // subtract the last reading:
  total = total - readings[readIndex];
  // read from the sensor:
  readings[readIndex] = micVal;
  // add the reading to the total:
  total = total + readings[readIndex];
  // advance to the next position in the array:
  readIndex = readIndex + 1;

  // if we're at the end of the array...
  if (readIndex >= numReadings) {
    // ...wrap around to the beginning:
    readIndex = 0;
  }

  // calculate the average:
  average = total / numReadings;
  analogWrite(micLED, map(average, 50, 900, 0, 255));
//  Serial.print("Mic: " );
//  Serial.println(micVal);


}
