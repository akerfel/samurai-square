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
  // save them in the Integer arraylist "scores"
  // We convert them from string --> integer --> string
  // We need to have them temporarily as integers in order to sort them
  // correctly.
  ArrayList<Integer> scores = new ArrayList<Integer>();
  BufferedReader reader = createReader("highscores.txt");
  String line = null;
  try {
    while ((line = reader.readLine()) != null) {
      scores.add(int(line));
    }
    reader.close();
  } catch (IOException e) {
    e.printStackTrace();
  }
  // add current score to strScores
  scores.add(score);
  Collections.sort(scores, Collections.reverseOrder());
  
  output = createWriter("highscores.txt");
  int i = 0;
  for (int someScore :scores) {
    output.println(str(someScore));
    i++;
    if (i > 10) {
      break;  
    }
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
