//create json object, which will store the json file
JSONObject json;
String myURL = "http://api.wunderground.com/api/xxx/forecast/q/15201.json";


void setup(){

  background(255);
  size(460, 320);
  loaddata();
}

void draw(){
  delay(60000);
  loaddata();
}


void loaddata(){
  //fetch the JSON object from our URL
  json = loadJSONObject(myURL);
  println(json);
  
  //get the "forecast" object from the larger packet
  JSONObject forecast = json.getJSONObject("forecast");
  
  //inside the "forecast" we want "simpleforecast"
  JSONObject results = forecast.getJSONObject("simpleforecast");
  println(results);
  
  //inside "simpleforecast" we want the Array called "forecastday"
  JSONArray collection = results.getJSONArray("forecastday");
  
  //lets store the number of entries in the "forecastday" array
  int sizeOfCollection = collection.size();
  
  //wal through each entry in the array with a for loop
  for(int i = 0; i < sizeOfCollection; i++)
  {
   //first, pull out the entry as a JSONObject
   JSONObject day = collection.getJSONObject(i);
   
   //then, pull out the "high" object, and then the nested "fahrenheit" object
   int high = day.getJSONObject("high").getInt("fahrenheit");
   
   //do the same with low
   int low = day.getJSONObject("low").getInt("fahrenheit");
   
   //print these out to make sure we're getting the correct data
   println("high: " + high);
   println("low: " + low);
    
    
    
   //lets draw something simple with the data we have
   float spacing = width/sizeOfCollection;

   float x = spacing * i + 40;
   float h = height - high * 1.6;
    
   stroke(255,0,0);
   strokeWeight(20);
   line(x, height, x, h);
   fill(0);
   text(high, x + 15, h);
   
   h = height - low;
    
   stroke(0,0,255);
   strokeWeight(20);
   line(x, height, x, h);
   fill(0);
   text(low, x + 15, h);    
  }
}
