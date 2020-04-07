public class Enemy {
  float x;
  float y = floor;
  int w = 25;
  int h = 25;
  float vx = 3;
  float vy = 0;
  boolean isAlive = true;
  
  public Enemy() {
    randomizeStartPosition();
  }
  
  void randomizeStartPosition() {
    if (random(0, 1) < 0.5) {
      x = 0;  
      vx = abs(vx);
    }
    else {
      x = width - w;
      vx = -abs(vx);
    }
  }
  
  void updatePosition() {
    x += vx;
  }
  
  void update() {
     if (isAlive) {
       updatePosition();
       checkIfHit();
     }
  }
  
  void checkIfHit() {
    if (player.isAttackingUpOrDown()) {
      if (rectsAreColliding(x, y, w, h, player.xsword, player.ysword, player.wsword, player.hsword)) {
        isAlive = false;
      }
    }
    // swap sword width and height if attacking left or right 
    else if (player.isAttackingLeftOrRight()) {
      if (rectsAreColliding(x, y, w, h, player.xsword, player.ysword, player.hsword, player.wsword)) {
        isAlive = false;
      }
    }
  }
}
