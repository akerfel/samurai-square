void drawEverything() {
  clear();
  drawFloor();
  drawEnemies();
  drawPlayer(); 
  drawGodModeText();
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
  if (player.isAttacking && player.attackDirection.equals("right") || player.attackDirection.equals("left")) {
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
