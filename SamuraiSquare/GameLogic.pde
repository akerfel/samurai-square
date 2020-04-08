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
