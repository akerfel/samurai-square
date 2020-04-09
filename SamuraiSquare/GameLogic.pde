import java.util.Iterator;

boolean shouldRemoveDeadEnemies = true;
int floor = 700;
int enemySpawnTimerInterval = 100;
int enemySpawnTimer = 10;
int score = 0;



void updateLogic() {
  player.update();
  updateEnemies();
  updateEnemySpawnTimer();
  if (shouldRemoveDeadEnemies) {
    removeDeadEnemies();
  }
}

void removeDeadEnemies() {
  Iterator<Enemy> itEnemies = enemies.iterator();
  while (itEnemies.hasNext()) {
    if (!itEnemies.next().isAlive) {
      itEnemies.remove();
    }
  }
}

void updateEnemySpawnTimer() {
  enemySpawnTimer--;
  if (enemySpawnTimer < 0) {
    spawnEnemy();
    enemySpawnTimer = enemySpawnTimerInterval;
  }
}

void gameOver() {
  gameState = GameState.GAMEOVER;  
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

void resetGame() {
  score = 0;
  enemies.clear();
  setup();  
}
