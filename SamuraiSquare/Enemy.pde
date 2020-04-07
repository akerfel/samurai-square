public class Enemy {
  float x;
  float y = floor;
  int w = 25;
  int h = 25;
  float vxe = 0.1;
  float vy = 0;
  
  public Enemy() {
    randomizeStartPosition();
  }
  
  void randomizeStartPosition() {
    if (random(0, 1) < 0.5) {
      x = 0;  
      vxe = 0.5;
    }
    else {
      x = width - w;
      vxe = -0.5;
    }
  }
  
  void updatePosition() {
    x += vxe;
  }
}
