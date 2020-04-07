ArrayList<Enemy> enemies = new ArrayList<Enemy>();
Enemy enemy1;

float x = 350;
float y = 700;
int w = 30;
int h = 30;
float vx = 4;
float vy = 0;
int floor = 700;
float upTickSpeed = 11;
float gravity = 0.8;

void setup() {
    size(800, 800);
    enemy1 = new Enemy();
    enemies.add(enemy1);
}

void draw() {
    drawEverything();
    updateLogic();
}

void updateLogic() {
  updatePlayerPosition();
  updateEnemyPositions();
}

void updateEnemyPositions() {
    for (Enemy enemy :enemies) {
      enemy.updatePosition();  
    }
}

void updatePlayerPosition() {
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
}

void keyPressed() {
  if (key == ' ' && vy == 0) {
    vy -= upTickSpeed;
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
      println("drew enemy at " + enemy.x);
    }
}

void drawPlayer() {
  fill(255, 0, 0);
  rect(x, y - h, w, h);
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
