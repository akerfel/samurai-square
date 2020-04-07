public class Enemy {
  float x;
  float y = 50;
  int w = 25;
  int h = 25;
  float vx = 3;
  float vy = 2;
  boolean isAlive = true;
  // when spawn: fall to ground, so it wont just spawn directly on the player
  boolean isFalling = true; 
  
  public Enemy() {
    randomizeStartPosition();
  }
  
  void randomizeStartPosition() {
    if (random(0, 1) < 0.5) {
      x = 50;  
      vx = abs(vx);
    }
    else {
      x = width - 50;
      vx = -abs(vx);
    }
  }
  
  void updatePosition() {
    if (isFalling) {
      println("is falling, y: " + y);
      y += vy;
      if (y >= floor) {
        y = floor;
        isFalling = false;
        vy = 0;
      }
    }
    // Else is on floor
    else {
      x += vx;
      if (x + w > width) {
        vx = -abs(vx);  
      }
      if (x < 0) {
        vx = abs(vx);  
      }
    }
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
