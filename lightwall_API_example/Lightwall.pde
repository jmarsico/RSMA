class Lightwall{
  String url;
  
  
  Lightwall(String _url){
    url = _url;
    String lines[] = loadStrings("http://67.205.143.120");
    println(lines[0]);
  }
    
  //  http://lightwall.carnegielibrary.org/explode?start_x=22&start_y=20&size=5
  void explode(int x, int y, int size){
    String request = url;
    
    //add the X location
    request += "/explode?start_x=";
    request += str(x);
    
    //add the Y location
    request += "&start_y=";
    request += str(y);
    
    //add the size
    request += "&size=";
    request += str(size);
    
    println(request);
    loadStrings(request);
  }
  
  //  http://lightwall.carnegielibrary.org/sweep?start_x=0&start_y=0&end_x=100&end_y=100&speed=100
  void sweep(int startX, int startY, int endX, int endY, int speed){
    String request = url;
    
    request += "/sweep?start_x=";
    request += str(startX);
    
    request += "&start_y=";
    request += str(startY);
    
    request += "&end_x=";
    request += str(endX);
    
    request += "&end_y=";
    request += str(endY);
    
    request += "&speed=";
    request += str(speed);
    
    println(request);
    loadStrings(request);
  }
  
  //  http://lightwall.carnegielibrary.org/dots?size=34&duration=99
  void dots(int size, int duration){
    String request = url;
    
    request += "/dots?size=";
    request += str(size);
    
    request += "&duration=";
    request += str(duration);
    
    println(request);
    loadStrings(request);
  }

}