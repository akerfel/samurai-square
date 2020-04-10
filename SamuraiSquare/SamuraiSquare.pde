import java.util.ArrayList;
import java.util.Collections;

// Declaring and instantiating 
Player player;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

// Cheats/Debug
boolean godMode = false;
boolean noEnemies = false;
boolean showDashesReady = false;    // should probably be turned off. Too much info at once.
boolean startRandomScore = true;
boolean enemiesFloorStart = true;

// misc
boolean shouldRemoveDeadEnemies = true;
int floor = 700;
int enemySpawnTimerInterval = 100;
int enemySpawnTimer = 10;
int score = 0;

public enum GameState {
  GAMEOVER,
  STARTSCREEN,
  GAMEACTIVE
}
GameState gameState;

PrintWriter output;

void setup() {
    size(1000, 800);
    player = new Player();
    gameState = GameState.GAMEACTIVE;
    activateCheats();
}

void activateCheats() {
  if (startRandomScore) {
      score = int(random(1, 100));
    }
  if (enemiesFloorStart) {
    spawnSomeFloorEnemies();
  }
}

void draw() {
  switch(gameState) {
    case GAMEACTIVE:
      drawEverything();
      updateLogic();
      break;
    case GAMEOVER:
      drawGameOver();
      break;
    case STARTSCREEN:
      break;
  }
}
