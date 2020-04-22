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
  
// Multiplier cheats/debug. Set to 1 for default behavior.
float spawnMultiplier = 1;
float armorSpawnMultipler = 1;
float fpsMultiplier = 1;        // for slowmo

// Declaring and instantiating 
Player player;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

// misc
boolean shouldRemoveDeadEnemies = true;
int floor = 700;
int enemySpawnTimerInterval = 100;      
int enemySpawnTimer = 10;
int score = 0;
float spawnArmorRate = 0.5;

public enum GameState {
  GAMEOVER,
  STARTSCREEN,
  GAMEACTIVE
}
GameState gameState;

PrintWriter output;

void setup() {
    size(900, 750);
    player = new Player();
    gameState = GameState.GAMEACTIVE;
    activateGameCheats(); // should only be activated at game launch, not every round
    activateRoundCheats(); // should be activated before every round
}

void activateGameCheats() {
   // empty atm
}

void activateRoundCheats() {
  if (startRandomScore) {
      score = int(random(1, 100));
    }
  if (dieInstant) {
    spawnSomeFloorEnemies();
  }
  frameRate(int(60 * fpsMultiplier));
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
  player = new Player();
  gameState = GameState.GAMEACTIVE;
  activateRoundCheats();
}
