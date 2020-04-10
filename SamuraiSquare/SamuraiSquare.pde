// Declaring and instantiating 
Player player;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

// Cheats/Debug
boolean godMode = false;
boolean noEnemies = false;
boolean showDashesReady = false;    // should probably be turned off. Too much info at once.

public enum GameState {
  GAMEOVER,
  STARTSCREEN,
  GAMEACTIVE
}
GameState gameState;

void setup() {
    size(1000, 800);
    player = new Player();
    gameState = GameState.GAMEACTIVE;
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
