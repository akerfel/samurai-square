public class Player {
  float x = 350;
  float y = 700;
  int w = 30;
  int h = 30;
  
  float vx = 4;
  float vy = 0;
  float upTickSpeed = 11;
  float gravity = 0.8;
  
void updatePosition() {
  x += vx;
  if (x + w > width) {
    vx = -abs(vx);  
  }
  if (x < 0) {
    vx = abs(vx);  
  }
  
  y += vy;
  if (y > floor) {
    y = floor;  
    vy = 0;
  }
  if (y < floor) {
    vy += gravity;
  }
}
}
