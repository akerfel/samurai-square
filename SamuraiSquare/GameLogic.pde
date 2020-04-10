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
  drawEverything();
  gameState = GameState.GAMEOVER; 
  saveNewHighScore();  // will only save if actually is new highscore
}

void saveHighscores(ArrayList<Integer> highscores) {
  output = createWriter("data/highscores.txt");
  int i = 0;
  for (int someScore :highscores) {
    output.println(str(someScore));
    i++;
    if (i > 10) {
      break;  
    }
  }
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file 
}

ArrayList<Integer> getHighscores() {
  ArrayList<Integer> highscores = new ArrayList<Integer>();
   // Read the lines from highscores.txt and
  // save them in the Integer arraylist "scores"
  // We convert them from string --> integer --> string (later).
  // Why? We need to have them temporarily as integers in order to sort them
  // correctly.
  BufferedReader reader = createReader("data/highscores.txt");
  String line = null;
  try {
    while ((line = reader.readLine()) != null) {
      highscores.add(int(line));
    }
    reader.close();
  } catch (IOException e) {
    e.printStackTrace();
  }
  return highscores;
}

void saveNewHighScore() {
  // If highscores.txt does not exist, create it
  createHighscoresFile();
  // Load old highscores from file into list
  ArrayList<Integer> highscores = getHighscores();
  // Add potentially new highscore
  highscores.add(score);
  // Sort highscores 
  Collections.sort(highscores, Collections.reverseOrder());
  // Save highscores from list into file
  saveHighscores(highscores);
}

void createHighscoresFile() {
  File f = dataFile("highscores.txt");  // automatically has "data/" in front
  boolean exists = f.isFile();
  if(!exists) {
    // Create "highscores.txt"
    output = createWriter("data/highscores.txt");
    output.flush(); // Writes the remaining data to the file
    output.close(); // Finishes the file
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
