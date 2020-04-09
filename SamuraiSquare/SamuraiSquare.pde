// Declaring and instantiating 
Player player;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

// Cheats/Debug
boolean godMode = false;
boolean showDashesReady = false;    // should probably be turned off. Too much info at once.

void setup() {
    size(1000, 800);
    player = new Player();
}

void draw() {
    if (player.isAlive) {
      drawEverything();
      updateLogic();
    }
    else {
      drawGameOver();
    }
}
