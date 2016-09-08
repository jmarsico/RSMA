//create json object, which will store the json file
JSONObject json;
String myURL = "http://api.wunderground.com/api/1e6c70af66a69318/forecast/q/15201.json";
float spacing;


void setup(){
  json = loadJSONObject(myURL);
  //println(json);
  background(255);
  size(460, 320);
  loaddata();
}

void draw(){
  
}


void loaddata(){
  
 
  JSONObject results = json.getJSONObject("forecast").getJSONObject("simpleforecast");
  print(results);
  
  JSONArray collection = results.getJSONArray("forecastday");
  
  int sizeOfCollection = collection.size();
  
  
  spacing = width/sizeOfCollection;
  
  for(int i = 0; i < sizeOfCollection; i++)
  {
   JSONObject day = collection.getJSONObject(i);
   int high = day.getJSONObject("high").getInt("fahrenheit");
   int low = day.getJSONObject("low").getInt("fahrenheit");
   println("high: " + high);
   println("low: " + low);
    
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
    
   //fill(0);
   //textAlign(LEFT);
   //strokeWeight(1);
   //pushMatrix();
   //translate(x,h);
   //rotate(-HALF_PI);
   //text(loc, 0,0);
   //popMatrix();
    
  }
}