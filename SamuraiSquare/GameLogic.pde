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
    enemySpawnTimer = enemySpawnTimerInterval;
  }
}

void gameOver() {
  gameState = GameState.GAMEOVER; 
  saveHighScore();
}

void saveHighScore() {
  //String[] highscores = loadStrings("highscores.txt");
  //highscores[0] = str(score);
  //saveStrings("highscores.txt", highscores);
  
  // Read the lines from highscores.txt and
  // save them in the string arraylist "strScores"
  ArrayList<String> strScores = new ArrayList<String>();
  BufferedReader reader = createReader("highscores.txt");
  String line = null;
  try {
    while ((line = reader.readLine()) != null) {
      strScores.add(line);
    }
    reader.close();
  } catch (IOException e) {
    e.printStackTrace();
  }
  // add current score to strScores
  strScores.add(str(score));
  
  output = createWriter("highscores.txt");
  for (String strScore : strScores) {
    output.println(strScore);
  }
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
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
