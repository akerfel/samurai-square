import java.util.ArrayList;
import java.util.Collections;

// Settings
boolean shouldDrawUsedDashSlots = false;  // greyed out. I like it false better. Easier to see slots left.

// Cheats/Debug
boolean godMode = false;
boolean noEnemies = false;
boolean showDashSlots = false;    // should probably be turned off. Too much info at once.
boolean startRandomScore = false;
boolean dieInstant = false;        // by spawning some enemies close to ground
boolean superHighWallJump = false;


// Declaring and instantiating 
Player player;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

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

void gameOver() {
  drawEverything();
  gameState = GameState.GAMEOVER; 
  saveCurrentScore();  // will only save if actually is new highscore
}

void resetGame() {
  score = 0;
  enemies.clear();
  setup();  
}
