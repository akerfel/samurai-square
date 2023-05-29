import java.util.Iterator;

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
        enemySpawnTimer = int(enemySpawnTimerInterval / spawnMultiplier);
    }
}

void spawnEnemy() {
    if (!noEnemies) {
        enemies.add(new Enemy());
    }
}

void spawnSomeFloorEnemies () {
    for (int i = 0; i < 5; i++) {
        enemies.add(new Enemy(i * 200, floor - 100));
    }
}

void updateEnemies() {
    for (Enemy enemy : enemies) {
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
