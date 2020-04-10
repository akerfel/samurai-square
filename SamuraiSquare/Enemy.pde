public class Enemy {
  int x;
  int y = 50;
  int w = 35;
  int h = 35;
  float vx = 2.5;
  float vy = 2.5;
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
  
  public Enemy(int x, int y) {
    this.x = x;
    this.y = y;
    randomizeArmor();
  }
  
  void randomizeArmor() {
    float actualSpawnArmorRate = spawnArmorRate * armorSpawnMultipler;
    if (random(0, 1) < actualSpawnArmorRate) {
      hasTopArmor = true;  
    }
    if (random(0, 1) < actualSpawnArmorRate) {
      hasBottomArmor = true;  
    }
    if (random(0, 1) < actualSpawnArmorRate) {
      hasLeftArmor = true;  
    }
    if (random(0, 1) < actualSpawnArmorRate) {
      hasRightArmor = true;  
    }
    if (hasTopArmor && hasRightArmor && hasLeftArmor) {
        hasTopArmor = false;
    }
  }
  
  void randomizeStartPosition() {
    x = int(random(50, width - w - 50));
  }
  
  void updatePosition() {
    if (isFalling) {
      y += vy;
      if (y + h >= floor) {
        y = floor - h;
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
    if (player.swordIsUpOrDown()) {
      if (rectsAreColliding(x, y, w, h, player.xsword, player.ysword, player.wsword, player.hsword)) {
        if ((!(player.swordDirection.equals("down") && this.hasTopArmor)) && (!(player.swordDirection.equals("up") && this.hasBottomArmor))) {
          isAlive = false;
          score++;
        }
      }
    }
    // swap sword width and height if attacking left or right 
    else if (player.swordIsLeftOrRight()) {
      if (rectsAreColliding(x, y, w, h, player.xsword, player.ysword, player.hsword, player.wsword)) {
        if ((!(player.swordDirection.equals("left") && this.hasRightArmor)) && (!(player.swordDirection.equals("right") && this.hasLeftArmor))) {
          isAlive = false;
          score++;
        }
      }
    }
  }
}
