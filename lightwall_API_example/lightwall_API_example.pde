
Lightwall lw;


void setup(){
    lw = new Lightwall("http://127.0.0.1");
    lw.explode(10,10,10);
    lw.sweep(0,0, 100,100, 100);
    lw.dots(90, 90);
}

void draw(){}


void keyReleased() {
  if (key == 'e') {
    lw.explode(10,10,10);
  }
  else if(key == 's'){
    lw.sweep(0,0,100,100,10);
  } else if(key == 'd'){
    lw.dots(20,50);
  }
  
}