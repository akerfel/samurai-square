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
  int hsword = 45;
  
  boolean isAttackingRight = false;
  int ticksTillAttackDone = 0;
  int ticksWhenAttackStart = 30;
  
  
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
  if (isAttackingRight) {
    xsword += w;  
    ticksTillAttackDone--;
  }
  if (ticksTillAttackDone == 0) {
    isAttackingRight = false;  
  }
  
}

void attackRight() {
  isAttackingRight = true;
  ticksTillAttackDone = ticksWhenAttackStart; 
}

}
