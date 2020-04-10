public class Player {
  
  // Misc 
  float gravity = 0.8;
  
  // Position
  int x = 350;
  int y = 700;
  
  // Dimensions
  int w = 40;
  int h = 40;
  
  // Velocity
  float vx = 5;
  float vy = 0;
  
  // Sword
  float xsword = x;
  float ysword = y;
  int wsword = 6;
  int hsword = h * 2;
  String swordDirection = "right";

  // Jump
  float upTickSpeed = 11;
  int maxJumpsReady = 2;
  int jumpsReady = maxJumpsReady;
  int collideWallTimer = 0;
  boolean touchedWallAndHaveNotTouchedFloorSince = false;
  
  // Dash. (Temporarily increases vx and stops y movement)
  int maxDashesReady = 2;
  int dashesReady = maxDashesReady;
  int dashTimerStartValue = 13; //speedBoostTimer will get this value when speed bost starts
  int dashTimer = 0; // time left until dash ends
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
}

void activateDash() {
  if (dashesReady > 0 && dashTimer == 0) {
    dashTimer = dashTimerStartValue;
    dashesReady--;
    if (jumpsReady == 0) {
      jumpsReady++;  
    }
    vy = 0;
  }
}

void updateCollideWallTimer() {
    collideWallTimer--;
}

void jump() {
  if (collideWallTimer > 0 || player.x < 5 || player.x > width - 5) {
      uptick(1.8);
  }
  else if (jumpsReady > 0) {
    uptick(1);
    jumpsReady--;
  }
}

void uptick(float multiplier) {
  player.vy = -player.upTickSpeed * multiplier;
}

void checkIfDie() {
  if (!godMode) {
    for (Enemy enemy : enemies) {
      if (enemy.isAlive && rectsAreColliding(x, y, w, h, enemy.x, enemy.y, enemy.w, enemy.h)) {
        gameOver();
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
  updateXpos(vx_temp);
  if (!(dashTimer > 0)) {
    updateYpos();
  }
}

void deactiveDash() {
  dashTimer = 0;  
}

void updateXpos(float vx_temp) {
  x += vx_temp;
  checkIfTouchWall();
  
}

void checkIfTouchWall() {
  if (x + w > width) {
    x = width - w;
    vx = -abs(vx);
    collideWallTimer = 15;
    deactiveDash();
    restoreSomeDashes();
  }
  if (x < 0) {
    x = 0;
    vx = abs(vx);
    collideWallTimer = 15;
    deactiveDash();
    restoreSomeDashes();
  }
}

void restoreSomeDashes() {
  if (dashesReady < maxDashesReady) {
      // Aöl dashes are restored if you touch two walls without touching the floor in between.
      if (touchedWallAndHaveNotTouchedFloorSince) {
        dashesReady = maxDashesReady;
      }
      // One dash is restored if you touch a wall.
      else {
        dashesReady++;  
      }
    }
  touchedWallAndHaveNotTouchedFloorSince = true;
}

void updateYpos() {
  y += vy;
  if (y + h == floor) {
     touchedWallAndHaveNotTouchedFloorSince = false;
  }
  if (y + h >= floor && vy > 0) {
    jumpsReady = maxJumpsReady;
    touchedWallAndHaveNotTouchedFloorSince = false;
  }
  if (y + h > floor) {
    y = floor - h;
    vy = 0;
  }
  if (y + h < floor) {
    vy += gravity;
  }  
}

void updateSwordPosition() {
    int playerCenterX = x + w/2;
    int playerCenterY = y + h/2;
    xsword = playerCenterX;
    ysword = playerCenterY;
    if (swordDirection.equals("right")) {
      xsword += w/2;
    }
    else if (swordDirection.equals("left")) {
      xsword -= w/2 + hsword;
    }
    else if (swordDirection.equals("up")) {
      ysword -= h/2 + hsword;
    }
    else if (swordDirection.equals("down")) {
      ysword += h/2;
    }
}

boolean swordIsLeftOrRight() {
    return (swordDirection.equals("right") || swordDirection.equals("left"));
}

boolean swordIsUpOrDown() {
    return (swordDirection.equals("up") || swordDirection.equals("down"));
}

}
