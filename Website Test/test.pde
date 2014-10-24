float x, y;
void setup(){
  size(400, 400);
  background(0);
  
  x = 0;
  y = height/2;
}
void draw(){
  background(0);
  ellipse(x,y,22,22);
  x = x + 1;
}
