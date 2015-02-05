//create json object, which will store the json file
JSONObject json;
String myURL = "https://www.kimonolabs.com/api/38lcd9rw?apikey=No7h5YUcyCWbbn7xjG0ukUrDZTpjWFUU";
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
  JSONObject results = json.getJSONObject("results");
  
  JSONArray collection = results.getJSONArray("collection1");
  
  int sizeOfCollection = collection.size();
  
  spacing = width/sizeOfCollection;
  
  for(int i = 0; i < sizeOfCollection; i++)
  {
    JSONObject quake = collection.getJSONObject(i);
    float mag = quake.getFloat("");
    JSONObject location = quake.getJSONObject("location");
    String loc = location.getString("text");
    println(mag);
    println(loc);
    
    float x = spacing * i +10;
    float h = height - mag*10;
    
    stroke(0);
    strokeWeight(5);
    line(x, height, x, h);
    
    fill(0);
    textAlign(LEFT);
    strokeWeight(1);
    pushMatrix();
    translate(x,h);
    rotate(-HALF_PI);
    text(loc, 0,0);
    popMatrix();
    
  }
}

