public class Player {
  float x = 350;
  float y = 700;
  int w = 40;
  int h = 40;

  float vx = 4;
  float vy = 0;
  float upTickSpeed = 11;
  float gravity = 0.8;
  float xsword = x;
  float ysword = y;
  int wsword = 6;
  int hsword = h * 2;

  boolean isAttacking = false;
  String attackDirection = "right";
  int ticksTillAttackDone = 0;
  int ticksWhenAttackStart = 10;

  boolean isInFirstJump = false;
  boolean isInDoubleJump = false;
  boolean isAlive = true;

  int jumpCounterInAir = 0;

  int collideWallTimer = 0;

  int temp = 0;
  
  // Dash. Temporarily increases vx and deactives gravity
  int dashTimerStartValue = 13; //speedBoostTimer will get this value when speed bost starts
  int dashTimer = 0;      // time left until speed boost ends
  int dashCooldownStartValue = 180;
  int dashCooldown = 0;
  int dashSpeed = 18;    

void update() {
  updatePosition();
  updateSwordPosition();
  updateCollideWallTimer();
  updateDashTimer();
  checkIfDie();
}

void updateDashTimer() {
  if (dashTimer > 0) {
    dashTimer--;  
  }
  if (dashCooldown > 0) {
    dashCooldown--;  
  }
}

void activateDash() {
  if (dashTimer == 0 && dashCooldown == 0) {
    dashTimer = dashTimerStartValue;
    dashCooldown = dashCooldownStartValue;
  }
}

void updateCollideWallTimer() {
    collideWallTimer--;
}

void jump() {
  if (collideWallTimer > 0) {
      uptick(1.5);
  }
  else if (jumpCounterInAir == 0 || jumpCounterInAir == 1) {
    uptick(1);
    jumpCounterInAir++;
  }
}

void uptick(float multiplier) {
  player.vy = -player.upTickSpeed * multiplier;
  temp++;
}

void checkIfDie() {
  if (!godMode) {
    for (Enemy enemy : enemies) {
      if (enemy.isAlive && rectsAreColliding(x, y, w, h, enemy.x, enemy.y, enemy.w, enemy.h)) {
        isAlive = false;
      }
    }
  }
}

void updatePosition() {
  float vx_temp = vx;
  if (dashTimer > 0) {
    if (vx > 0) {
      vx_temp = dashSpeed;
    }
    else {
      vx_temp = -dashSpeed;
    }
  }
  updatexpos(vx_temp);
  if (!(dashTimer > 0)) {
    updateypos();
  }
}

void updatexpos(float vx_temp) {
  x += vx_temp;
  if (x + w > width) {
    vx = -abs(vx);
    collideWallTimer = 10;
  }
  if (x < 0) {
    vx = abs(vx);
    collideWallTimer = 10;
  }
}

void updateypos() {
  y += vy;
  if (y >= floor && vy > 0) {
    jumpCounterInAir = 0;
  }
  if (y > floor) {
    y = floor;
    vy = 0;
  }
  if (y < floor) {
    vy += gravity;
  }  
}

void updateSwordPosition() {
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

boolean isAttackingLeftOrRight() {
    return (isAttacking && (attackDirection.equals("right") || attackDirection.equals("left")));
}

boolean isAttackingUpOrDown() {
    return (isAttacking && (attackDirection.equals("up") || attackDirection.equals("down")));
}

void attack(String direction) {
  isAttacking = true;
  attackDirection = direction;
  ticksTillAttackDone = ticksWhenAttackStart;
}

}
