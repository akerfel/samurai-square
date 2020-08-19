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
    int vertical_wsword = 6;
    int vertical_hsword = h * 2;
    int wsword = vertical_wsword;
    int hsword = vertical_hsword;
    String swordDirection = "down";

    // Jump
    float upTickSpeed = 11;
    int maxJumpSlots = 2;
    int jumpSlots = maxJumpSlots;

    // Walljump and wallTouchTimer
    boolean touchedWallAndHaveNotTouchedFloorSince = false;
    float wallJumpMultiplier = 1;
    boolean dashRestoresAllJumpSlots = false; // should not be turned on. Gameplay should not be about flying.
    int distanceToWallForWallJump = 30;

    // Dash. (Temporarily increases vx and stops y movement)
    int maxDashSlots = 3;
    int dashSlots = maxDashSlots;
    int dashSlotsRestoredAfterWallTouch = 2;
    int dashTimerStartValue = 13; //speedBoostTimer will get this value when speed bost starts
    int dashTimer = 0; // time left until dash ends
    int dashSpeed = 18;

    void update() {
      updatePosition();
      updateSwordPosition();
      updateDashTimer();
      checkIfDie();
    }
    
    void updateDashTimer() {
      if (dashTimer > 0) {
        dashTimer--;
      }
    }
    
    void activateDash() {
      if (dashSlots > 0 && dashTimer == 0) {
        dashTimer = dashTimerStartValue;
        dashSlots--;
        if (jumpSlots < maxJumpSlots) {
          if (dashRestoresAllJumpSlots) {
            jumpSlots = maxJumpSlots;
          }
          else {
            jumpSlots++;
          }
        }
        vy = 0;
      }
    }
    
    void walljump() {
      if (superHighWallJump) {
        uptick(1 * 3);
      }
      else {
        uptick(1 * wallJumpMultiplier);
      }
    }
    
    void jump() {
      if ((y < floor - w) && (x < distanceToWallForWallJump || x + w > width - distanceToWallForWallJump)) {
          walljump();
      }
      else if (jumpSlots > 0) {
        uptick(1);
        jumpSlots--;
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
        deactiveDash();
        restoreSomeDashes();
      }
      if (x < 0) {
        x = 0;
        vx = abs(vx);
        deactiveDash();
        restoreSomeDashes();
      }
    }
    
    void restoreSomeDashes() {
      if (dashSlots < maxDashSlots) {
          // All dashes are restored if you touch two walls without touching the floor in between.
          if (touchedWallAndHaveNotTouchedFloorSince) {
            dashSlots = maxDashSlots;
          }
          // One dash is restored if you touch a wall.
          else {
            dashSlots += dashSlotsRestoredAfterWallTouch;
          }
          // Make sure you dont have over max amount of dash slots
          if (dashSlots > maxDashSlots) {
            dashSlots = maxDashSlots;
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
        jumpSlots = maxJumpSlots;
        touchedWallAndHaveNotTouchedFloorSince = false;
      }
      if (y + h > floor) {
        y = floor - h;
        vy = 0;
      }
      if (y + h < floor) {
        vy += gravity;
      }
      if (y < 0 ) {
        vy = 0;
        y = 0;
      }
    }
    
    void updateSwordPosition() {
        // Default sword position: "down"
        // Players center
        xsword = x + w/2;
        ysword = y + h/2;
        // Set width and height to vertical width/height
        wsword = vertical_wsword;
        hsword = vertical_hsword;
        
        switch (swordDirection) {
            // move sword up
            case("up"): 
                ysword -= vertical_hsword;
                break;
            // swap sword width and height
            case("right"):
                wsword = vertical_hsword;
                hsword = vertical_wsword;
                break;
            // swap sword width and height and move left
            case("left"):
                wsword = vertical_hsword;
                hsword = vertical_wsword;
                xsword -= vertical_hsword;
                break;
        }
    }
}
