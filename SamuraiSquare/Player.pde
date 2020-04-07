public class Player {
  float x = 350;
  float y = 700;
  int w = 30;
  int h = 30;
  
  float vx = 4;
  float vy = 0;
  float upTickSpeed = 11;
  float gravity = 0.8;
  float xsword = x;
  float ysword = y;
  int wsword = 6;
  int hsword = h * 3/2;
  
  boolean isAttacking = false;
  String attackDirection = "right";
  int ticksTillAttackDone = 0;
  int ticksWhenAttackStart = 10;
  
  
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
  xsword = x;
  ysword = y;
  if (isAttacking) {
    if (attackDirection.equals("right")) {
      xsword += w;  
    }
    else if (attackDirection.equals("left")) {
      xsword -= 2 * w;
    }
    else if (attackDirection.equals("up")) {
      ysword -= 2 * h;
    }
    else if (attackDirection.equals("down")) {
      ysword += h;
    }
    ticksTillAttackDone--;
  }
  if (ticksTillAttackDone == 0) {
    isAttacking = false;  
  }
  
}

void attack(String direction) {
  isAttacking = true;
  attackDirection = direction;
  ticksTillAttackDone = ticksWhenAttackStart; 
}

}
