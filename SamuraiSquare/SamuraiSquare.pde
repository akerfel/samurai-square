ArrayList<Enemy> enemies = new ArrayList<Enemy>();

Player player;
int floor = 700;
int enemySpawnTimerInterval = 150;
int enemySpawnTimer = 10;
boolean godMode = false;


void setup() {
    size(1000, 800);
    player = new Player();
    // createStartEnemies(3); // closer to the ground. not using atm.
}

void createStartEnemies(int n) {
  for (int i = 0; i < n; i++) {
    Enemy newEnemy = new Enemy();
    int startY = floor - i * 200;
    if (startY < 0) {
      startY = 0;
    }
    newEnemy.y = startY;
    //enemies.add(newEnemy);
  }
}

void draw() {
    if (player.isAlive) {
      drawEverything();
      updateLogic();
    }
    else {
      gameOver();
    }
}

void gameOver() {
  drawGameOver();
}

void updateLogic() {
  player.update();
  updateEnemies();
  updateEnemySpawnTimer();
}

void updateEnemySpawnTimer() {
  enemySpawnTimer--;
  if (enemySpawnTimer < 0) {
    spawnEnemy();
    enemySpawnTimer = enemySpawnTimerInterval;
  }
}

void spawnEnemy() {
    enemies.add(new Enemy());
}

void updateEnemies() {
    for (Enemy enemy :enemies) {
      enemy.update();  
    }
}

// Returns true if the two rectangels a and b are colliding
boolean rectsAreColliding(float ax, float ay, int aw, int ah, float bx, float by, int bw, int bh) {
   return 
   (ax < bx + bw &&
   ax + aw > bx &&
   ay < by + bh &&
   ay + ah > by);
}

void keyPressed() {
  if (key == ' ') {
    player.jump();
  }
  if (!player.isAlive && key == ' ') {
    setup();
  }
  if (key == CODED) {
      if (keyCode == RIGHT) {
        player.attack("right");
      }
      if (keyCode == LEFT) {
        player.attack("left");
      }
      if (keyCode == UP) {
        player.attack("up");
      }
      if (keyCode == DOWN) {
        player.attack("down");
      }
    }
    
   
}

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
  // If attacking left or right: swap sword width with height
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
