void drawEverything() {
  clear();
  drawFloor();
  drawEnemies();
  drawPlayer(); 
  drawGodModeText();
  drawScore();
  drawDashReady();
}

void drawDashReady() {
  if (player.dashCooldown == 0) {
    fill(0, 200, 0);
    circle(20, height - 20, 25);
  }
}

void drawScore() {
  fill(color(255, 255, 255));
  textSize(32);
  text(score, width - 60, 60);
}

void drawGodModeText() {
  if (godMode) {
    text("God Mode: ON", width - 150, 10);
  }
}

void drawEnemies() {
  for (Enemy enemy : enemies) {
      drawEnemy(enemy); 
    }
}

void drawPlayer() {
  fill(255, 0, 0);
  rect(player.x, player.y - player.h, player.w, player.h);
  drawSword();
  }

void drawSword() {
  fill(217, 217, 217);
  int swordHeight = player.hsword;
  int swordWidth = player.wsword;
  // If attacking left or right: swap sword width with height
  if (player.swordIsLeftOrRight()) {
    int temp = swordHeight;
    swordHeight = swordWidth;
    swordWidth = temp;
  }
  rect(player.xsword + player.w/2, player.ysword - player.h*2/3, swordWidth, swordHeight);
}

void drawEnemy(Enemy enemy) {
  if (enemy.isAlive) { 
    fill(0, 100, 0); 
  }
  else {
    fill(147,130,0); 
  }
  rect(enemy.x, enemy.y - enemy.h, enemy.w, enemy.h);
  drawEnemyArmor(enemy);
}

void drawEnemyArmor(Enemy enemy) {
  fill(98, 74, 46);
  if (enemy.hasTopArmor) {
    rect(enemy.x, enemy.y - enemy.h, enemy.w, enemy.h/4);
  }
  if (enemy.hasBottomArmor) {
    rect(enemy.x, enemy.y + enemy.h * 3/4 - enemy.h, enemy.w, enemy.h / 4);
  }
  if (enemy.hasLeftArmor) {
    rect(enemy.x, enemy.y - enemy.h, enemy.w/4, enemy.h);
  }
  if (enemy.hasRightArmor) {
    rect(enemy.x + enemy.w * 3/4, enemy.y - enemy.h, enemy.w / 4, enemy.h);
  }
}

void drawFloor() {
  fill(133,94,66);
  rectMode(CORNERS);
  rect(0, floor, width, height);
  rectMode(CORNER);
}

void drawGameOver() {
  text("Game over", width/2, height/2);
}
