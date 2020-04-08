public class Enemy {
  int x;
  int y = 50;
  int w = 35;
  int h = 35;
  float vx = 3;
  float vy = 2;
  boolean isAlive = true;
  // when spawn: fall to ground, so it wont just spawn directly on the player
  boolean isFalling = true; 
  
  
  boolean hasTopArmor;
  boolean hasBottomArmor;
  boolean hasLeftArmor;
  boolean hasRightArmor;
  
  
  public Enemy() {
    randomizeStartPosition();
    randomizeArmor();
  }
  
  void randomizeArmor() {
    if (random(0, 1) < 0.5) {
      hasTopArmor = true;  
    }
    if (random(0, 1) < 0.5) {
      hasBottomArmor = true;  
    }
    if (random(0, 1) < 0.5) {
      hasLeftArmor = true;  
    }
    if (random(0, 1) < 0.5) {
      hasRightArmor = true;  
    }
  }
  
  void randomizeStartPosition() {
    x = int(random(0, width));
  }
  
  void updatePosition() {
    if (isFalling) {
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
        if ((!(player.attackDirection.equals("down") && this.hasTopArmor)) && (!(player.attackDirection.equals("up") && this.hasBottomArmor))) {
          isAlive = false;
        }
      }
    }
    // swap sword width and height if attacking left or right 
    else if (player.isAttackingLeftOrRight()) {
      if (rectsAreColliding(x, y, w, h, player.xsword, player.ysword, player.hsword, player.wsword)) {
        if ((!(player.attackDirection.equals("left") && this.hasRightArmor)) && (!(player.attackDirection.equals("right") && this.hasLeftArmor))) {
          isAlive = false;
        }
      }
    }
  }
}
