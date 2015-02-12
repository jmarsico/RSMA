/* Code based on perlin function in this source
 http://code.google.com/p/britable/source/browse/trunk/britable/britable.pde#
 http://code.google.com/p/britable/
 
 kasperkamperman.com 16-09-2012
 */

#include <DmxSimple.h>

const byte amountOfLights = 8;

byte lightArray[amountOfLights];  // lightArray is in bytes just values in range of 0 - 255

unsigned long currentTime;     // for time measuring purposes
unsigned long passedTime;     // for time measuring purposes
unsigned long longestTime = 0; // for time measuring purposes

float perlinTimeInc      = 0.07;
float perlinXInc         = 0.05;  
float perlinTimePosition;
int mappedVal= 0;
int minVal = 30;
//int maxVal = 100;
int valDiff = 70;




void setup(){   
  Serial.begin(9600);
  DmxSimple.usePin(2);
}

void loop(){   
  currentTime = micros(); // store current time
  
  //set up values from potentiometer

  for(byte i=0;i<amountOfLights;i++){ 
    float x = float(i)*perlinXInc; // input for x value in the renderNoise function

    byte val = renderNoise(x, perlinTimePosition+i*i); 
    mappedVal=map(val,0,255, minVal, (minVal + valDiff));
    lightArray[i] = mappedVal;
    DmxSimple.write(i+1,mappedVal);

  }

  // go a step further in time (input for y function in perlin noise)
  perlinTimePosition = perlinTimePosition + perlinTimeInc;  

  // calculate the time the whole calculation took
  passedTime = micros()-currentTime;

  // because times will variate, remember the maximum time it took
  if(passedTime>longestTime) longestTime = passedTime;

  // print the time it took for the current calculation and the maximum time
  /*
    Serial.print("time:  ");
   Serial.print(passedTime);
   Serial.print(" max: ");
   Serial.println(longestTime);
   Serial.print("array: ");
   */

  // print the array to see the result
  // I calculate back to float just for printing purposes
  // I this way so actually see a perlin effect
  for(byte i=0;i<amountOfLights;i++)
  { 
    float printFloat = (lightArray[i]); 
    Serial.print(printFloat,0);
    Serial.print(", ");

  }
  Serial.println();
  Serial.println();

  delay(60);
}




// returns a value between 0 - 255 for lights
byte renderNoise(float x, float y)
{	
  float noise;

  // 2 octaves
  //noise = perlin_function(x,y) + perlin_function(x*2,y*2);

  noise = perlin_function(x,y); // gives noise in the range of -1 to +1
  noise = noise *128+127;       // scale to a number between 0 - 255

  return (byte) noise;  
}

float perlin_function(float x, float y)
{
  int fx = floor(x);
  int fy = floor(y);

  float s,t,u,v;
  s=perlin_noise_2d(fx,fy);
  t=perlin_noise_2d(fx+1,fy);
  u=perlin_noise_2d(fx,fy+1);
  v=perlin_noise_2d(fx+1,fy+1);

  float inter1 = lerp(s,t,x-fx);
  float inter2 = lerp(u,v,x-fx);  

  return lerp(inter1,inter2,y-fy);
}

float perlin_noise_2d(int x, int y) {
  long n=(long)x+(long)y*57;
  n = (n<<13)^ n;
  return 1.0 - (((n *(n * n * 15731L + 789221L) + 1376312589L)  & 0x7fffffff) / 1073741824.0);    
}

float lerp(float a, float b, float x)
{ 
  return a + x * (b - a);
}





