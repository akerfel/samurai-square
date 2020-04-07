ArrayList<Enemy> enemies = new ArrayList<Enemy>();
Enemy enemy1;
Player player;
int floor = 700;

void setup() {
    size(800, 800);
    enemy1 = new Enemy();
    player = new Player();
    enemies.add(enemy1);
}

void draw() {
    drawEverything();
    updateLogic();
}

void updateLogic() {
  player.updatePosition();
  updateEnemyPositions();
}

void updateEnemyPositions() {
    for (Enemy enemy :enemies) {
      enemy.updatePosition();  
    }
}

void keyPressed() {
  if (key == ' ' && player.vy == 0) {
    player.vy -= player.upTickSpeed;
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
  drawPlayer();   
  drawEnemies();
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
  fill(0, 100, 0);
  rect(enemy.x, enemy.y - enemy.h, enemy.w, enemy.h);
}

void drawFloor() {
  fill(133,94,66);
  rectMode(CORNERS);
  rect(0, floor, width, height);
  rectMode(CORNER);
}
