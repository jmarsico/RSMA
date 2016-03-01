import http.requests.*;

String url = "https://piserver.arc.cmu.edu/piwebapi/streams/P0-MYhSMORGkyGTe9bdohw0AOxcBAAV0lOLTYyTlBVMkJWTDIwXENNVS9TQ1NDIEdBVEVTL1JPT0YvQUhVLTkgU0YgSU5URVJGQUNFL1BPV0VSIEtX/value";
void setup(){
  JSONObject j = new JSONObject();
  
  GetRequest get = new GetRequest(url);
  get.addUser("Sustainable", "Sustainable1!@");
  get.send();
  
  j = parseJSONObject(get.getContent());
  
  println("raw: " + get.getContent());
  println("json format:");
  println(j);
  
}